# 02 - Ansible Inventory

## What is Ansible inventory?

Ansible inventory is the file or source that contains the list of **managed nodes / target hosts** Ansible can connect to.

It tells Ansible:

- which servers to manage
- how hosts are grouped
- what IP address or hostname each server has
- what user, port, or SSH key to use

So inventory is basically the **host list for Ansible**.

---

## Why inventory is needed

Ansible control node cannot connect to servers unless it knows:

- server names
- IP addresses
- host groups
- connection details

Inventory provides all that information.

---

## Example of simple inventory

```ini
[web]
10.0.0.11
10.0.0.12

[db]
10.0.0.21

[all:vars]
ansible_user=ubuntu
```

Here:

- `web` and `db` are groups
- hosts are listed under groups
- variables can also be defined

---

## Types of inventory

Ansible inventory is commonly understood in **2 ways**.

### 1. Static inventory
You manually define hosts in a file.

Example:
- adding server IPs directly in `hosts` or `inventory.ini`

### 2. Dynamic inventory
Ansible fetches hosts automatically from external sources such as:

- AWS EC2
- Azure
- GCP
- Kubernetes
- inventory plugins
- custom scripts

---

## In how many formats can we write inventory file?

The **2 most common file formats** are:

1. **INI format**
2. **YAML format**

---

## 1. INI format inventory

This is the traditional and very common format.

Example:

```ini
[web]
server1 ansible_host=10.0.0.11
server2 ansible_host=10.0.0.12

[db]
server3 ansible_host=10.0.0.21

[web:vars]
ansible_user=ubuntu
```

### Explanation
- `[web]` = group name
- `server1`, `server2` = host aliases
- `ansible_host` = real IP/hostname
- `[web:vars]` = variables for all hosts in that group

---

## 2. YAML format inventory

This is more structured and easier to read in larger environments.

Example:

```yaml
all:
  children:
    web:
      hosts:
        server1:
          ansible_host: 10.0.0.11
        server2:
          ansible_host: 10.0.0.12
    db:
      hosts:
        server3:
          ansible_host: 10.0.0.21
  vars:
    ansible_user: ubuntu
```

### Explanation
- `all` = top-level group
- `children` = subgroups
- `hosts` = systems in each group
- `vars` = variables shared across hosts/groups

---

## Common inventory structure

Inventory can contain:

- hosts
- groups
- child groups
- variables

---

## Host example

```ini
server1 ansible_host=10.0.0.11
```

Here:
- `server1` = alias used by Ansible
- `ansible_host` = actual IP

---

## Group example

```ini
[web]
server1
server2
```

This creates a group called `web`.

You can run commands on all hosts in that group.

Example:

```bash
ansible web -m ping
```

---

## Group variables example

```ini
[web:vars]
ansible_user=ubuntu
ansible_port=22
```

These values apply to all hosts in the `web` group.

---

## Child groups example

```ini
[web]
server1
server2

[app]
server3

[prod:children]
web
app
```

Here:
- `prod` is a parent group
- `web` and `app` are child groups

Now running against `prod` includes all hosts in both groups.

---

## Default inventory location

The common default inventory location is:

```bash
/etc/ansible/hosts
```

If no custom inventory file is given, Ansible often looks here.

---

## Custom inventory location

In real projects, teams often keep inventory inside the project/repository, for example:

```text
inventory
inventory.ini
hosts
inventory/dev
inventory/test
inventory/prod
```

Then they run playbooks like:

```bash
ansible-playbook -i inventory.ini playbook.yml
```

or

```bash
ansible-playbook -i inventory/prod playbook.yml
```

---

## Inventory command examples

### Ping all hosts
```bash
ansible all -m ping
```

### Ping web group
```bash
ansible web -m ping
```

### Use specific inventory file
```bash
ansible all -i inventory.ini -m ping
```

### Run playbook with custom inventory
```bash
ansible-playbook -i inventory.ini site.yml
```

---

## Host variables example

You can define variables directly per host.

```ini
[web]
server1 ansible_host=10.0.0.11 ansible_user=ubuntu
server2 ansible_host=10.0.0.12 ansible_user=ec2-user
```

This is useful when different hosts require different usernames or settings.

---

## Important connection variables

Common inventory variables:

- `ansible_host` = actual IP or DNS name
- `ansible_user` = SSH username
- `ansible_port` = SSH port
- `ansible_ssh_private_key_file` = path to private key

Example:

```ini
[web]
server1 ansible_host=10.0.0.11 ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/id_rsa
```

---

## Inventory in AWS / EC2 example

```ini
[web]
web1 ansible_host=54.12.34.56 ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/mykey.pem

[db]
db1 ansible_host=54.98.76.54 ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/mykey.pem
```

Here Ansible knows:

- which hosts exist
- which username to use
- which private key to use

---

## Static vs dynamic inventory

### Static inventory
- manually maintained
- simple
- good for labs and small setups

### Dynamic inventory
- automatically pulls current hosts
- useful in cloud environments
- helpful when servers are created and deleted frequently

Example:
- EC2 instances auto-discovered from AWS

---

## How inventory fits in Ansible architecture

```text
Control Node
    |
    | reads inventory
    v
Inventory File / Inventory Source
    |
    | provides host list, groups, variables
    v
Managed Nodes / Target Servers
```

Ansible first checks inventory to know where and how to connect.

---

## Best points to remember

- Inventory is the **list of target hosts**
- It can be **static** or **dynamic**
- Common formats are **INI** and **YAML**
- Default location is usually:

```bash
/etc/ansible/hosts
```

- Real projects often use custom inventory files inside the repo

---

## Short summary

Ansible inventory is the source that tells Ansible which hosts to manage and how to connect to them. It can be written in INI or YAML format and may be static or dynamic. The common default inventory location is `/etc/ansible/hosts`, although many real projects use custom inventory files stored in their own directories.
