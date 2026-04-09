## What is an Ansible playbook?

An **Ansible playbook** is a YAML file that contains one or more **plays**.
It defines:

- which hosts to target
- what tasks to run
- what modules to use
- in what order actions should happen

Playbooks are usually saved with `.yml` or `.yaml` extension.

---

## 1. Playbook

A **playbook** is the full YAML file.

It can contain:

- one play
- multiple plays

### Example

```yaml
---
- name: Update web servers
  hosts: webservers
  remote_user: root

  tasks:
    - name: Ensure apache is at the latest version
      ansible.builtin.yum:
        name: httpd
        state: latest

    - name: Write the apache config file
      ansible.builtin.template:
        src: /srv/httpd.j2
        dest: /etc/httpd.conf

- name: Update db servers
  hosts: databases
  remote_user: root

  tasks:
    - name: Ensure postgresql is at the latest version
      ansible.builtin.yum:
        name: postgresql
        state: latest

    - name: Ensure that postgresql is started
      ansible.builtin.service:
        name: postgresql
        state: started
```

### Meaning

This one playbook has:

- one play for `webservers`
- one play for `databases`

So:

**Playbook = whole YAML file**

---

## 2. Play

A **play** is one block inside a playbook.

A play tells Ansible:

- which hosts to target
- which tasks to execute on those hosts

### Example

```yaml
- name: Install and configure Nginx
  hosts: webservers
  tasks:
    - name: Install Nginx
      ansible.builtin.apt:
        name: nginx
        state: present
```

### Meaning

This is one play:

- target hosts = `webservers`
- action = install nginx

So:

**Play = one section inside a playbook that runs tasks on a host group**

---

## 3. Task

A **task** is a single action inside a play.

Examples:

- install a package
- copy a file
- start a service
- create a user

Tasks run from top to bottom.

### Example

```yaml
tasks:
  - name: Install Nginx
    ansible.builtin.apt:
      name: nginx
      state: present

  - name: Start Nginx service
    ansible.builtin.service:
      name: nginx
      state: started
```

### Meaning

This play has two tasks:

1. install nginx
2. start nginx service

So:

**Task = one individual step in a play**

---

## 4. Module

A **module** is the Ansible component that does the actual work.

Common modules:

- `ansible.builtin.apt`
- `ansible.builtin.yum`
- `ansible.builtin.copy`
- `ansible.builtin.service`
- `ansible.builtin.template`

### Example

```yaml
- name: Install Nginx
  ansible.builtin.apt:
    name: nginx
    state: present
```

Here:

- task name = `Install Nginx`
- module = `ansible.builtin.apt`

So:

**Module = the tool used inside a task**

---

## 5. Collection

A **collection** is a packaged bundle of Ansible content.

It can include:

- modules
- roles
- plugins
- playbooks
- documentation

Collections help organize and reuse Ansible content.

### Example structure

```text
my_collection/
├── roles/
│   └── my_role/
│       └── tasks/
│           └── main.yml
├── plugins/
│   └── modules/
│       └── my_module.py
└── README.md
```

### Example usage

```yaml
- name: Use a module from a collection
  community.general.some_module:
    option: value
```

So:

**Collection = package of Ansible content**

---

## Related playbook fields

### `hosts`
Defines which inventory hosts the play runs on.

```yaml
hosts: webservers
```

### `become`
Runs tasks with elevated privilege such as `sudo`.

```yaml
become: true
```

### `remote_user`
Specifies which user Ansible should use to connect.

```yaml
remote_user: ubuntu
```

### `name`
Used to describe the play or task.

```yaml
- name: Install apache
```

---

## Hierarchy

```text
Playbook
 ├── Play
 │    ├── Task
 │    │    └── Module
 │    ├── Task
 │    │    └── Module
 │
 ├── Play
 │    ├── Task
 │    │    └── Module
```

---

## Simple relationship

- **Playbook** = full file
- **Play** = one section inside file
- **Task** = one action inside play
- **Module** = tool used by task
- **Collection** = package/library of Ansible content

---

## Quick memory

- **Playbook** = book
- **Play** = chapter
- **Task** = step
- **Module** = tool
- **Collection** = library/package
