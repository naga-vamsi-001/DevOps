## What is Ansible?
Ansible is an automation tool used in DevOps to automate server setup, software installation, application deployment, cloud operations, and network tasks.

It is mainly used for:
- Provisioning
- Configuration management
- Deployment
- Network automation

---

## Why Ansible when Puppet exists?
Both Puppet and Ansible are configuration management tools, but they work differently.

### Puppet
- Agent-based
- Uses Puppet DSL
- Pull model
- Target servers have Puppet agents
- Agents periodically contact Puppet Server and pull configuration

### Ansible
- Agentless
- Uses YAML playbooks
- Push model
- Control node connects over SSH or WinRM
- Easier to learn and faster to start

### Why many teams choose Ansible
- No agent installation on target servers
- Easier setup and maintenance
- YAML is more readable than Puppet DSL
- Good for quick automation and orchestration
- Common in DevOps pipelines

---

## Ansible Architecture
Ansible usually has one control node and many managed nodes.

### Components
- **Control Node**: machine where Ansible is installed and from where playbooks are run
- **Inventory**: file containing target servers
- **Managed Nodes**: target servers Ansible connects to
- **SSH/WinRM**: connection method used by Ansible
- **Playbooks**: YAML files containing automation tasks

### Diagram
```text
                 +----------------------+
                 |   Ansible Control    |
                 |   Node / Server      |
                 |  Playbooks, Inventory|
                 +----------+-----------+
                            |
             SSH / WinRM    |   PUSH
                            v
      +----------------+  +----------------+  +----------------+
      | Target Server1 |  | Target Server2 |  | Target Server3 |
      | nginx, app, cfg|  | java, users    |  | patches, files |
      +----------------+  +----------------+  +----------------+
```

---

## Puppet Architecture
Puppet usually has a Puppet Server and Puppet Agents installed on target servers.

### Components
- **Puppet Server**: stores manifests, modules, and policies
- **Puppet Agent**: installed on each target server
- **Managed Nodes**: servers that pull configuration from Puppet Server

### Diagram
```text
                   PUPPET (PULL)
     +---------------------------------------+
     | Puppet Server                         |
     | manifests + modules + policies        |
     +---------------------------------------+
             ^           ^           ^
             |           |           |
          pull by     pull by     pull by
          agent       agent       agent
             |           |           |
        +--------+   +--------+   +--------+
        | Node 1 |   | Node 2 |   | Node 3 |
        | agent  |   | agent  |   | agent  |
        +--------+   +--------+   +--------+
```

---

## Push and Pull Model

## What is Push?
Push means the central server starts the action and sends changes to the target machines.

### In Ansible
- Admin runs a playbook from control node
- Control node connects to target servers
- It pushes tasks and configuration to them

### Simple meaning
"Go now and do this on these servers."

### Push Diagram
```text
Control Node  -------->  Server A
             -------->  Server B
             -------->  Server C
```

---

## What is Pull?
Pull means the target machine itself asks the central server for configuration.

### In Puppet
- Puppet agent runs on each target server
- Agent contacts Puppet Server periodically
- Agent pulls required configuration and applies it

### Simple meaning
"Let me check what configuration I should have."

### Pull Diagram
```text
Server A  --------\
Server B  ---------+----->  Central Puppet Server
Server C  --------/
```

---

## Push vs Pull Summary

| Feature | Ansible | Puppet |
|---|---|---|
| Model | Push | Pull |
| Agent required | No | Yes |
| Connection style | SSH/WinRM from control node | Agent contacts Puppet Server |
| Execution | Usually on demand | Periodic |
| Best for | Automation, deployment, orchestration | Continuous config enforcement |
| Language | YAML | Puppet DSL |
| Setup | Simpler | Heavier |

---

## What Ansible Can Do
Ansible can do the following major DevOps tasks:

1. Provisioning
2. Configuration management
3. Deployment
4. Network automation

---

## 1. Provisioning
Provisioning means creating infrastructure or resources.

### Examples
- EC2 instances
- VPCs
- Subnets
- Security groups
- Load balancers
- S3 buckets
- EBS volumes

### Important note
Ansible can do provisioning, but Terraform is often preferred for large infrastructure provisioning.

### Common real-world pattern
- Terraform creates infrastructure
- Ansible configures infrastructure

---

## 2. Configuration Management
Configuration management means setting up the server or system the way it should be.

### Examples
- Install nginx
- Install Java or Python
- Create users and groups
- Copy configuration files
- Set file permissions
- Start and enable services
- Update packages

### Purpose
To keep all servers consistent across environments like dev, test, stage, and prod.

---

## 3. Deployment
Deployment means releasing application code or package to the target environment.

### Examples
- Copy application artifact to server
- Pull code from Git
- Install dependencies
- Replace old version with new version
- Restart the service
- Verify app status

### Common CI/CD usage
- Jenkins triggers Ansible
- GitHub Actions triggers Ansible
- Azure DevOps triggers Ansible

---

## 4. Network Automation
Ansible is also used for automating network device operations.

### Examples
- Configure routers
- Configure switches
- Update firewall rules
- Manage VLANs
- Backup device configuration
- Standardize network settings

### Network vendors often automated with Ansible
- Cisco
- Juniper
- Arista
- Other supported network platforms

---

## Easy Definitions to Remember
- **Provisioning** = create infrastructure
- **Configuration management** = set up infrastructure correctly
- **Deployment** = release application to infrastructure
- **Network automation** = automate network device configuration

---

## Real-World Example
Suppose a company wants to host a Python web app on AWS.

### Step 1 - Provisioning
Create:
- EC2 instance
- Security group
- EBS volume

### Step 2 - Configuration Management
Set up:
- Python
- Nginx
- App user
- Environment file

### Step 3 - Deployment
Deploy:
- application code
- dependencies
- service startup commands

### Step 4 - Network Automation
Optionally automate:
- firewall changes
- routing rules
- load balancer configs

---


## Memory Trick
- **Ansible** = push from control node
- **Puppet** = pull by agent
- **Terraform** = create infra
- **Ansible** = configure and deploy on infra
