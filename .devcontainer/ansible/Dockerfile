ARG VARIANT
FROM mcr.microsoft.com/devcontainers/${VARIANT} AS base

# Install Ansible and ansible-lint
COPY .github/scripts/ansible-install.sh /tmp/ansible-install.sh
RUN bash /tmp/ansible-install.sh && rm /tmp/ansible-install.sh
