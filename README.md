# Spot Tunnels

## Project description

The Spot Tunnels project is designed to simplify the management and deployment of secure tunnels, primarily using VLESS and Shadowsocks protocols. It leverages Podman for containerization and Taskfile for task automation, making it easy to set up and maintain a network of secure tunnels.

This project is built with flexibility in mind, allowing you to define your infrastructure and user access through simple YAML configuration files. It automates the process of generating configurations, deploying containers, and managing network settings across multiple hosts.

## Key features

- **Multi-Host deployment**: Designed to manage tunnels across multiple servers.
- **VLESS and Shadowsocks support**: Supports both VLESS (with WebSocket) and Shadowsocks protocols for secure tunneling.
- **Automated configuration**: Automatically generates configurations based on your YAML.
- **Dynamic ingress**: Uses Reproxy for dynamic ingress, simplifying routing and SSL management.
- **Taskfile automation**: Employs Taskfile for defining and running tasks, streamlining operations.
- **YAML configuration**: Uses YAML files for defining hosts, users, and their access rights.
settings.
- **SSH key management**: Generates and manages SSH keys for users.
- **Podman-based**: Uses Podman for container management, offering a daemonless container runtime.

## Prerequisites

Before you begin, ensure you have the following installed:

- **openssh client**: For secure remote access.
- **task**: A task runner/build tool ([taskfile.dev](https://taskfile.dev)).
- **podman**: A daemonless container engine.
- **jq**: A lightweight and flexible command-line JSON processor.
- **yq**: A lightweight and portable command-line YAML processor.

## Installation

Clone the repository:

```bash
git clone https://github.com/igk1972/spot-tunnels
cd spot-tunnels
```

You need to have install these tools using the `tunnels-requirements-install` script:

```bash
./tunnels-requirements-install
```

### Configure environment variables

Create a .env file in the root directory of the project. You can use the provided .env file as a template. Customize the following variables:

- DNS_ZONE: Your DNS zone (e.g. domain.my).
- SSH_KEY: The path to your SSH private key.
- SSH_LOGIN: The default SSH login user (default: root).
- INVENTORY_FILE: Path to your inventory file (default: tunnels-inventory.yml).
- USERS_FILE: Path to your users file (default: tunnels-users.yml).
- CONTAINER_NAMESPACE: The namespace for your containers (default: tunnels-glider).
- LINK_NAME_PREFIX: A prefix for link names (default blank).

### Configure inventory

You need to create your own `tunnels-inventory.yml` file based on the example provided in `example/tunnels-inventory.yml`. This file defines the hosts and their configurations.

**Important:** Do not modify the `example/tunnels-inventory.yml` file directly. Create your own `tunnels-users.yml` file and place it in the root directory of the project.
Then, update the `INVENTORY_FILE` variable in your `.env` file to point to your new file.

Each host should have:

- name: A unique name for the host.
- host: The hostname or IP address.
- port: The SSH port (default: 22).
- user: The SSH user (default: root).
- ssh_key: The path to a specific SSH key (optional).

### Configure users

You need to create your own `tunnels-users.yml` file based on the example provided in `example/tunnels-users.yml`. This file defines the users who can access the tunnels.

**Important:** Do not modify the `example/tunnels-users.yml` file directly. Create your own `tunnels-users.yml` file and place it in the root directory of the project.
Then, update the `USERS_FILE` variable in your `.env` file to point to your new file.

Each user should have:

- name: A unique name for the user.
- uuid: A unique UUID for the user.
- vless_hosts: A string or regular expression for allowed VLESS hosts (optional).
- shadowsock_port: A port for Shadowsocks (optional).
- shadowsock_pass: A password for Shadowsocks (optional).
- shadowsock_hosts: A string or regular expression for allowed Shadowsocks hosts (optional).

## Usage

Commands:

```bash
./tunnels
```

```bash
./tunnels apply
```

```bash
./tunnels keys
```

```bash
./tunnels status
```

## Contributing

Contributions are welcome! If you'd like to contribute to the project, please follow these steps:

- Fork the repository.
- Create a new branch for your changes.
- Make your changes and commit them.
- Push your branch to your fork.
- Submit a pull request.

## License

This project is licensed under the MIT License.
