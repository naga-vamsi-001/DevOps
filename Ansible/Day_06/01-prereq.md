## 1. What is a Collection in Ansible?

A **collection** in Ansible is a packaged bundle of reusable Ansible content.

A collection can contain:
- modules
- plugins
- roles
- documentation

Collections are used to extend Ansible with ready-made content from Ansible, the community, cloud providers, or internal teams.

### Simple meaning
- **Collection** = package
- **Module** = actual unit that does the work

For example, the AWS collection provides modules for working with:
- EC2
- S3
- VPC
- IAM

## How to install a collection

Sample AWS collection install:

```bash
ansible-galaxy collection install amazon.aws
```

## How to use a collection

After installing a collection, you use its modules by calling the **fully qualified collection name**.

Example module name format:

```text
amazon.aws.ec2_instance
amazon.aws.s3_bucket
```

Here:
- `amazon.aws` = collection name
- `ec2_instance` or `s3_bucket` = module name

So when using collections in Ansible, the common method is:
- install the collection
- call its module with full name

---

## Setup EC2 Collection and Authentication

### Install boto3

```bash
pip install boto3
```

### Install AWS Collection

```bash
ansible-galaxy collection install amazon.aws
```

### Setup Vault

#### 1. Create a password for vault

```bash
openssl rand -base64 2048 > vault.pass
```

#### 2. Add your AWS credentials using the below vault command

```bash
ansible-vault create group_vars/all/pass.yml --vault-password-file vault.pass
```

You can store secrets inside that encrypted file, such as:
- AWS access key
- AWS secret key
- AWS region

Example content inside `group_vars/all/pass.yml`:

```yaml
aws_access_key: YOUR_ACCESS_KEY
aws_secret_key: YOUR_SECRET_KEY
aws_region: us-east-1
```

---

## 2. Variables in Ansible

### What are variables?

Variables are named values used to store reusable data in Ansible.

They help avoid hardcoding values such as:
- package names
- usernames
- ports
- file paths
- environment names
- regions

### How variables are defined

Variables are usually defined as:

```yaml
key: value
```

Example:

```yaml
app_name: myapp
app_port: 8080
env: dev
```

### How variables are used

Variables are referenced using Jinja expression format:

```yaml
{{ app_name }}
{{ app_port }}
```

---

## Ansible has many places to define variables

In full detail, Ansible has around **22 places/sources** where variables can be defined.

But in practical daily use, the most common methods are these:

### 1. Playbook vars
Defined directly in the playbook.

### 2. Inventory vars
Defined in the inventory file.

### 3. `group_vars`
Defined for a group of hosts.

### 4. `host_vars`
Defined for a specific host.

### 5. Role defaults
Defined in `roles/<role_name>/defaults/main.yml`.

### 6. Role vars
Defined in `roles/<role_name>/vars/main.yml`.

### 7. Extra vars
Passed at runtime using `-e`.

Example:

```bash
ansible-playbook -e "app_name=myapp"
```
---

## Simple memory

- **Collection** = packaged Ansible content
- **Variables** = reusable values in Ansible
- Ansible has around **22 variable sources**, but the most used ones are playbook vars, inventory vars, group_vars, host_vars, role defaults, role vars, and extra vars.
