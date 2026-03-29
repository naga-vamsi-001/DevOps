## Ansible Galaxy

Ansible Galaxy is used to **find, install, and share Ansible roles and collections**.

Use it when you want to:
- reuse existing roles
- install roles from Galaxy
- publish your own role

---

## Check the CLI

```bash
ansible-galaxy --version
```

---

## Create a role skeleton

```bash
ansible-galaxy init my_role
```

This creates a standard role structure like:

```text
my_role/
├── defaults/
│   └── main.yml
├── files/
├── handlers/
│   └── main.yml
├── meta/
│   └── main.yml
├── tasks/
│   └── main.yml
├── templates/
├── tests/
│   ├── inventory
│   └── test.yml
└── vars/
    └── main.yml
```

---

## Install a role from Galaxy

```bash
ansible-galaxy role install geerlingguy.apache
```

Install into a local project folder:

```bash
ansible-galaxy role install geerlingguy.apache -p roles/
```

---

## Install roles from a requirements file

Create `requirements.yml`:

```yaml
roles:
  - name: geerlingguy.apache
  - name: geerlingguy.mysql
```

Install:

```bash
ansible-galaxy install -r requirements.yml -p roles/
```

---

## Use a role in a playbook

```yaml
---
- hosts: webservers
  become: true
  roles:
    - geerlingguy.apache
```

Run the playbook:

```bash
ansible-playbook -i inventory playbook.yml
```

---

## Publish your own role

### 1. Go to your role folder

```bash
cd my_role
```

### 2. Push the role to GitHub

```bash
git init
git remote add origin https://github.com/your_github_username/my_role.git
git add .
git commit -m "Initial commit"
git branch -M main
git push -u origin main
```

### 3. Import the role into Ansible Galaxy

```bash
ansible-galaxy role import your_github_username my_role (API load-token)
```

---

## Useful commands

Search for a role:

```bash
ansible-galaxy search apache
```

List installed roles:

```bash
ansible-galaxy role list
```

Remove a role:

```bash
ansible-galaxy role remove geerlingguy.apache
```

---

## Simple summary

- `ansible-galaxy init` → create a role skeleton
- `ansible-galaxy role install` → install a role
- `ansible-galaxy install -r` → install roles from a file
- `ansible-galaxy role import` → publish your GitHub role to Galaxy
