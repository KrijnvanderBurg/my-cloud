#!/usr/bin/env python3
"""
Dynamic Ansible Inventory from Terraform Outputs
Generates inventory for pfSense NVA VMs from hub state files
"""

import json
import subprocess
import sys


def get_terraform_output(state_dir):
    """Get Terraform outputs as JSON"""
    try:
        result = subprocess.run(
            ["terraform", "output", "-json"],
            cwd=state_dir,
            capture_output=True,
            text=True,
            check=True
        )
        return json.loads(result.stdout)
    except subprocess.CalledProcessError:
        return {}


def build_inventory():
    """Build dynamic inventory from Terraform outputs"""
    inventory = {
        "_meta": {
            "hostvars": {}
        },
        "all": {
            "children": ["nva_primary", "nva_secondary", "jumpbox"]
        },
        "nva_primary": {
            "hosts": []
        },
        "nva_secondary": {
            "hosts": []
        },
        "jumpbox": {
            "hosts": []
        }
    }

    # Hub environments to query
    hub_environments = [
        {
            "name": "gwc",
            "path": "../2_platform_connectivity/environments/dev-gwc"
        },
        {
            "name": "weu",
            "path": "../2_platform_connectivity/environments/dev-weu"
        }
    ]

    for hub in hub_environments:
        outputs = get_terraform_output(hub["path"])

        if not outputs:
            continue

        region = hub["name"]

        # Primary NVA
        if "nva_primary_ip" in outputs:
            host = f"nva-primary-{region}"
            inventory["nva_primary"]["hosts"].append(host)
            inventory["_meta"]["hostvars"][host] = {
                "ansible_host": outputs["nva_primary_ip"]["value"],
                "ansible_user": "nvaadmin",
                "region": region,
                "nva_role": "primary",
                "lb_ip": outputs.get("nva_lb_ip", {}).get("value", ""),
                "peer_ip": outputs.get("nva_secondary_ip", {}).get("value", "")
            }

        # Secondary NVA
        if "nva_secondary_ip" in outputs:
            host = f"nva-secondary-{region}"
            inventory["nva_secondary"]["hosts"].append(host)
            inventory["_meta"]["hostvars"][host] = {
                "ansible_host": outputs["nva_secondary_ip"]["value"],
                "ansible_user": "nvaadmin",
                "region": region,
                "nva_role": "secondary",
                "lb_ip": outputs.get("nva_lb_ip", {}).get("value", ""),
                "peer_ip": outputs.get("nva_primary_ip", {}).get("value", "")
            }

        # Jumpbox
        if "jumpbox_private_ip" in outputs:
            host = f"jumpbox-{region}"
            inventory["jumpbox"]["hosts"].append(host)
            inventory["_meta"]["hostvars"][host] = {
                "ansible_host": outputs["jumpbox_private_ip"]["value"],
                "ansible_user": "jmpadmin",
                "region": region
            }

    return inventory


def main():
    if len(sys.argv) == 2 and sys.argv[1] == "--list":
        print(json.dumps(build_inventory(), indent=2))
    elif len(sys.argv) == 3 and sys.argv[1] == "--host":
        # Return empty dict for host-specific vars (all in _meta)
        print(json.dumps({}))
    else:
        print("Usage: {} --list | --host <hostname>".format(sys.argv[0]))
        sys.exit(1)


if __name__ == "__main__":
    main()
