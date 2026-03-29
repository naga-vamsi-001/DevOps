# Ansible Roles

An **Ansible role** is a **ready-made folder structure** used to organize automation for one specific purpose.

Think of a role like a **package** for one job.

Examples:
- one role to install **Apache**
- one role to install **Nginx**
- one role to create **users**
- one role to configure **MySQL**

Instead of writing one big playbook with everything mixed together, roles help you split work into smaller, reusable parts.

---

## Very simple definition

A role is a **reusable and organized way** to keep:
- tasks
- files
- templates
- variables
- handlers

for one application or one configuration.

---

## Why use roles?

Roles make Ansible code:

- easier to read
- easier to reuse
- easier to manage
- easier to maintain

### Without roles
You may have one long playbook with:
- install package
- copy config
- start service
- restart service
- variables
- templates

This becomes hard to manage.

### With roles
You keep related things in one folder.

Example:
- `apache` role → Apache-related work
- `mysql` role → MySQL-related work
- `user_setup` role → user creation work

---

## Easy real-life example

Suppose you want to set up a web server.

Tasks needed:
1. install Apache
2. copy `index.html`
3. start Apache service

You can put all of that inside one role called `apache`.

Then in the playbook you just write:

```yaml
---
- hosts: webservers
  become: true
  roles:
    - apache
```

That means:

**Run the apache role on webservers**

---

## Main parts of an Ansible role

### Tasks
The actual steps the role performs.

Example:
- install package
- copy file
- start service

### Handlers
Special tasks that run only when notified.

Example:
- restart apache if config file changed

### Files
Static files copied directly to managed nodes.

Example:
- `index.html`

### Templates
Dynamic files using Jinja2 variables.

Example:
- `httpd.conf.j2`

### Vars
Variables used by the role.

### Defaults
Default values for variables. These can be overridden.

### Meta
Information about the role, such as dependencies.

### Library
Custom modules if needed.

### Module_defaults
Default parameters for modules in the role.

### Lookup_plugins
Custom lookup plugins.

---

## Standard role directory structure

```text
<role_name>/
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
├── vars/
│   └── main.yml
```

A bigger role may also have:

```text
<role_name>/
├── library/
├── module_defaults/
├── lookup_plugins/
```

---

## What each folder means

### `tasks/main.yml`
Main list of steps.

Example:
```yaml
- name: Install apache2
  ansible.builtin.apt:
    name: apache2
    state: present
```

### `handlers/main.yml`
Runs when triggered by `notify`.

Example:
```yaml
- name: Restart apache
  ansible.builtin.service:
    name: apache2
    state: restarted
```

### `files/`
Stores static files.

Example:
- `index.html`

### `templates/`
Stores Jinja2 templates.

Example:
- `apache.conf.j2`

### `vars/main.yml`
Stores role variables.

### `defaults/main.yml`
Stores default values.

### `meta/main.yml`
Stores metadata and dependencies.

---

## Simple difference: role vs playbook

### Playbook
A playbook tells Ansible:
- which hosts to target
- which roles or tasks to run

### Role
A role organizes the automation logic.

### Easy memory
- **Playbook** = what to run
- **Role** = organized package of how to do it

---

## Example without role

```yaml
---
- hosts: webservers
  become: true
  tasks:
    - name: Install apache2
      ansible.builtin.apt:
        name: apache2
        state: present

    - name: Copy index file
      ansible.builtin.copy:
        src: index.html
        dest: /var/www/html/index.html

    - name: Start apache
      ansible.builtin.service:
        name: apache2
        state: started
        enabled: true
```

This works, but becomes large over time.

---

## Example with role

### Playbook
```yaml
---
- hosts: webservers
  become: true
  roles:
    - apache
```

### Inside role
The `apache` role contains:
- install tasks
- copy file tasks
- service tasks
- templates
- handlers

This is cleaner.

---

## Why roles are useful

### Modularity
Breaks big automation into smaller pieces.

### Reusability
Use the same role in many playbooks.

### Maintainability
Update one role and reuse it everywhere.

### Readability
Playbooks stay short and clean.

### Collaboration
Different team members can work on different roles.

### Consistency
Same steps can be used across dev, test, and prod.

---

## Best way to understand role

Think like this:

- A **playbook** is the main instruction file.
- A **role** is a folder that keeps all related automation for one job.
- A **task** is one step.
- A **handler** is a special step triggered only when needed.

### Simple analogy
- **Playbook** = movie script
- **Role** = one actor’s full file
- **Tasks** = actions that actor performs

---

## One-line summary

**Ansible role is a reusable folder structure that organizes all automation related to one specific component or task.**
