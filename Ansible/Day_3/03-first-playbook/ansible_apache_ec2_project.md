# Ansible Project: EC2 Passwordless SSH, Inventory, Apache Deployment, and Web Validation

## Project Overview

In this project, I created an AWS EC2 instance and configured **passwordless SSH authentication** using `ssh-copy-id`. I used an **Ansible inventory file (`inventory.ini`)** to store the managed node details and executed an Ansible playbook from the **master/control node**.

The playbook installed **Apache (`apache2`)** on the managed node, copied a custom `index.html` file into the Apache web root, and started the Apache service. After that, I enabled **HTTP inbound traffic on port 80** in the EC2 security group, copied the **public IP address** of the managed node, and verified the web page in the browser.

This project demonstrates the basic end-to-end Ansible flow:

- connect from control node to managed node without password
- define target host in inventory
- run playbook from control node
- install and configure Apache on managed node
- expose port 80
- validate the deployed HTML page in browser

---

## Architecture Used

### Control Node / Master Node
This is the machine where:

- Ansible is installed
- the inventory file is stored
- the playbook is stored
- the command `ansible-playbook -i inventory.ini first-playbook.yaml` is executed

### Managed Node
This is the EC2 instance that Ansible manages remotely over SSH.

On this managed node, Ansible:

- connected using SSH
- installed Apache
- copied the HTML file
- ensured the Apache service was running

---

## Inventory File

The inventory file was used to store the target host details.

Example:

```ini
[all]
ubuntu@98.82.22.123
```

### Purpose of inventory
The inventory tells Ansible:

- which server to connect to
- which SSH user to use
- which hosts belong to which group

In this project, the inventory was passed explicitly using:

```bash
ansible-playbook -i inventory.ini first-playbook.yaml
```

---

## Playbook Used

The playbook installed Apache, copied the HTML file, and started the service.

```yaml
---
- name: Install Apache and copy index file
  hosts: all
  become: true

  tasks:
    - name: Install apache2
      ansible.builtin.apt:
        name: apache2
        state: present
        update_cache: yes

    - name: Copy index.html file
      ansible.builtin.copy:
        src: index.html
        dest: /var/www/html/index.html
        owner: root
        group: root
        mode: '0644'

    - name: Ensure apache2 service is running
      ansible.builtin.service:
        name: apache2
        state: started
        enabled: true
```

---

## Step-by-Step Flow of the Project

### Step 1: Create EC2 instance
An EC2 instance was created in AWS.

### Step 2: Connect first time using `.pem`
Initially, the EC2 instance was accessed using the AWS private key:

```bash
ssh -i <path-to-pem-file> ubuntu@<public-ip>
```

### Step 3: Configure passwordless SSH using `ssh-copy-id`
The public key from the control node was copied to the managed node so that future logins would not require typing a password.

Example flow:

```bash
ssh-copy-id ubuntu@<public-ip>
```

After this setup, Ansible could connect from the control node to the managed node using SSH key-based authentication.

### Step 4: Create inventory file
The managed node public IP and SSH user were stored in `inventory.ini`.

### Step 5: Create playbook
A YAML playbook was created to:

- install Apache
- copy `index.html`
- start and enable Apache service

### Step 6: Run playbook from control node
The playbook was executed using:

```bash
ansible-playbook -i inventory.ini first-playbook.yaml
```

### Step 7: Allow HTTP traffic in security group
Inbound rule for **HTTP / port 80** was enabled in the EC2 security group.

### Step 8: Validate Apache on managed node
Verification was done on the managed node using commands such as:

```bash
ps -ef | grep apache2
systemctl status apache2
cd /var/www/html
ls
```

### Step 9: Open public IP in browser
The public IP of the EC2 instance was opened in the browser:

```text
http://<public-ip>
```

The page displayed:

```text
Hello first playbook Ansible
```

---

## Explanation of Terminal Output

When the command below was executed:

```bash
ansible-playbook -i inventory.ini first-playbook.yaml
```

Ansible printed several sections in the terminal.

### 1. `PLAY [all]`
Example:

```text
PLAY [all]
```

### Meaning
This means Ansible started a **play** for the host group `all` from the playbook.

In this project, `hosts: all` was used, so Ansible targeted all hosts listed in the inventory.

---

### 2. `TASK [Gathering Facts]`
Example:

```text
TASK [Gathering Facts]
```

### Meaning
Before running your actual tasks, Ansible collects system information about the managed node. This process is called **fact gathering**.

Facts can include:

- hostname
- IP address
- OS name
- distribution
- Python interpreter
- CPU and memory details
- network details

Ansible uses these facts internally and they can also be referenced in playbooks using variables.

Example fact variables:

- `ansible_hostname`
- `ansible_distribution`
- `ansible_default_ipv4.address`

So in simple words:

**Gathering Facts = Ansible first learns information about the target server before running tasks.**

---

### 3. `TASK [Install apache httpd]`
Example:

```text
TASK [Install apache httpd]
```

### Meaning
This is one of the tasks from the playbook.

Ansible is now executing the package installation step on the managed node.

In your playbook, this task uses the `apt` module to ensure `apache2` is installed.

If the package is already installed, Ansible usually reports `ok`.
If something had to be installed or changed, Ansible would report `changed`.

---

### 4. `TASK [Copy file with owner and permissions]`
Example:

```text
TASK [Copy file with owner and permissions]
```

### Meaning
This task copies `index.html` from the control node to the target path on the managed node:

```text
/var/www/html/index.html
```

It also applies:

- owner
- group
- file permissions

This is the step that places the custom web page content on the Apache server.

---

### 5. `ok: [ubuntu@98.82.22.123]`
Example:

```text
ok: [ubuntu@98.82.22.123]
```

### Meaning
This means the task completed successfully on that managed host.

`ok` indicates:

- the host was reachable
- the task succeeded
- no failure happened

If nothing needed to be changed, Ansible usually shows `ok`.
If a change was made, Ansible may show `changed`.

---

### 7. `PLAY RECAP`
Example:

```text
PLAY RECAP
ubuntu@98.82.22.123 : ok=3 changed=0 unreachable=0 failed=0 skipped=0 rescued=0 ignored=0
```

### Meaning
This is the final summary of what happened for each managed host.

#### `ok=3`
Three tasks completed successfully.

In your run, these were:

- Gathering Facts
- Install apache
- Copy file

#### `changed=0`
No new change was made during that run.

This usually means the server was already in the desired state.
For example:

- Apache was already installed
- the file was already present with the same content and permissions

If it had installed Apache for the first time or changed the file, this value would be greater than 0.

#### `unreachable=0`
Ansible successfully connected to the host. No SSH connectivity issue occurred.

#### `failed=0`
No task failed.

#### `skipped=0`
No task was skipped.

#### `rescued=0`
No error handling block rescued a failed task.

#### `ignored=0`
No failed task was ignored.

### Simple summary of recap
The recap tells you:

- how many tasks succeeded
- how many changes were made
- whether any host was unreachable
- whether any task failed

---

## Why `changed=0` is Actually Good

Many beginners think `changed=0` means nothing happened, but in Ansible this is often a good sign.

It means Ansible checked the server and confirmed that it was already in the desired state.

This is called **idempotent behavior**.

### Idempotent meaning
If you run the same playbook again and again:

- it should not break anything
- it should not create duplicate changes
- it should only change what is necessary

So if Apache was already installed and the file was already correct, Ansible says:

```text
changed=0
```

That means the system is already compliant with the playbook.

---

## Validation Performed

### Terminal validation on managed node
The managed node was checked using:

```bash
ps -ef | grep apache2
```

This confirmed Apache processes were running.

```bash
systemctl status apache2
```

This confirmed the service was:

- loaded
- active (running)
- enabled

```bash
cd /var/www/html
ls
```

This confirmed that `index.html` was copied into the correct directory.

### Browser validation
The EC2 public IP was opened in a browser.

The browser displayed the HTML page successfully, confirming that:

- Apache was installed
- Apache was running
- port 80 was open
- the custom HTML page was copied correctly

---

## Key Ansible Concepts Used in This Project

### Playbook
The YAML file that defines the automation steps.

### Play
The block that targets `hosts: all`.

### Task
Each individual action, such as:

- install package
- copy file
- start service

### Module
The built-in Ansible modules used in this project:

- `ansible.builtin.apt`
- `ansible.builtin.copy`
- `ansible.builtin.service`

### Inventory
The file that stores the managed node information.

### Managed Node
The EC2 instance that receives the configuration.

### Control Node
The machine from which Ansible commands are executed.

---

## Outcome of the Project

This project was completed successfully.

### Final result
- passwordless SSH was configured between control node and managed node
- inventory file was used to define the target host
- Ansible playbook was executed successfully
- Apache was installed and running on the managed node
- custom `index.html` was copied to Apache web root
- HTTP inbound traffic on port 80 was enabled
- the application page was successfully opened in the browser using the EC2 public IP

---

## Suggested Places to Add Screenshots

You mentioned that you will add pictures later. These are the best places to insert them.

### Screenshot 1: Terminal output of playbook execution
![arch.png](https://raw.githubusercontent.com/naga-vamsi-001/Images/main/Ansible_first_project/terminal.png)

- `PLAY [all]`
- `TASK [Gathering Facts]`
- task execution lines
- `PLAY RECAP`

### Screenshot 2: Managed node verification
![arch.png](https://raw.githubusercontent.com/naga-vamsi-001/Images/main/Ansible_first_project/Ec2_instance.png)

- `ps -ef | grep apache2`
- `systemctl status apache2`
- `/var/www/html/index.html`

### Screenshot 3: Browser output
![arch.png](https://raw.githubusercontent.com/naga-vamsi-001/Images/main/Ansible_first_project/output.png)

```text
Hello first playbook Ansible
```

---

## Short Interview Explanation

I created an AWS EC2 managed node and configured passwordless SSH access from the Ansible control node using `ssh-copy-id`. I stored the target host details in `inventory.ini` and ran an Ansible playbook from the control node. The playbook installed Apache, copied a custom `index.html` file into `/var/www/html`, and ensured the Apache service was running. After enabling inbound HTTP access on port 80, I validated the deployment both from the terminal and through the browser using the EC2 public IP.

---

## Commands Used in the Project

```bash
ssh -i <path-to-pem-file> ubuntu@<public-ip>
ssh-copy-id ubuntu@<public-ip>
ansible-playbook -i inventory.ini first-playbook.yaml
ps -ef | grep apache2
systemctl status apache2
cd /var/www/html
ls
```

---

## Final Note

This project is a good beginner DevOps/Ansible example because it covers multiple core concepts together:

- SSH access
- passwordless authentication
- inventory
- playbook execution
- package installation
- file copy
- service management
- security group update
- browser-based validation

