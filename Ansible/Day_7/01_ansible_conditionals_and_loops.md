## 1. What are conditionals in Ansible?

Conditionals in Ansible are used to control whether a task should run or not.

They are useful when:
- a task should run only on certain OS types
- a service should start only in production
- a package should install only if a variable is set
- a command should run only when a condition is true

In Ansible, conditionals are usually written with:

```yaml
when:
```

---

## 2. Why use conditionals?

Without conditionals, every task runs for every target host.

With conditionals, you can make playbooks smarter.

Example:
- install `apache2` on Ubuntu
- install `httpd` on Red Hat
- create a user only if it does not already exist
- restart a service only in specific environments

---

## 3. Basic conditional syntax

```yaml
- name: Install Apache on Ubuntu
  ansible.builtin.apt:
    name: apache2
    state: present
  when: ansible_os_family == "Debian"
```

### Meaning
This task runs only if the target host belongs to the Debian OS family.

---

## 4. Example: OS-based conditionals

```yaml
---
- hosts: all
  become: true
  tasks:
    - name: Install Apache on Debian systems
      ansible.builtin.apt:
        name: apache2
        state: present
        update_cache: yes
      when: ansible_os_family == "Debian"

    - name: Install Apache on RedHat systems
      ansible.builtin.yum:
        name: httpd
        state: present
      when: ansible_os_family == "RedHat"
```

### Meaning
- Ubuntu/Debian → use `apt`
- RHEL/CentOS/Amazon Linux type systems → use `yum`

---

## 5. Multiple conditions

You can use more than one condition.

```yaml
- name: Start service only in production
  ansible.builtin.service:
    name: apache2
    state: started
  when:
    - env == "prod"
    - ansible_os_family == "Debian"
```

### Meaning
The task runs only if:
- `env` is `prod`
- and OS family is `Debian`

---

## 6. Using `and`, `or`, `not`

### `and`
```yaml
when: env == "prod" and ansible_os_family == "Debian"
```

### `or`
```yaml
when: ansible_os_family == "Debian" or ansible_os_family == "RedHat"
```

### `not`
```yaml
when: env != "dev"
```

or

```yaml
when: not feature_enabled
```

---

## 7. Conditionals with variables

```yaml
---
- hosts: all
  vars:
    install_nginx: true

  tasks:
    - name: Install nginx
      ansible.builtin.apt:
        name: nginx
        state: present
      when: install_nginx
```

### Meaning
If `install_nginx` is true, the task runs.

---

## 8. Conditionals with registered variables

Sometimes a task stores output in a variable using `register`.

Then another task can decide based on that result.

```yaml
---
- hosts: all
  tasks:
    - name: Check if httpd is installed
      ansible.builtin.command: rpm -q httpd
      register: httpd_check
      ignore_errors: true

    - name: Print message if httpd is installed
      ansible.builtin.debug:
        msg: "httpd is already installed"
      when: httpd_check.rc == 0
```

### Meaning
- `register` stores command result
- `rc == 0` means success
- debug message runs only if package exists

---

## 9. What are loops in Ansible?

Loops are used to repeat the same task for multiple items.

They are useful for:
- installing multiple packages
- creating multiple users
- copying multiple files
- creating multiple directories

In Ansible, loops are commonly written with:

```yaml
loop:
```

---

## 10. Why use loops?

Without loops, you may write repeated tasks like this:

```yaml
- name: Install git
  ansible.builtin.apt:
    name: git
    state: present

- name: Install curl
  ansible.builtin.apt:
    name: curl
    state: present

- name: Install vim
  ansible.builtin.apt:
    name: vim
    state: present
```

With a loop, you can write it once.

---

## 11. Basic loop example

```yaml
- name: Install packages
  ansible.builtin.apt:
    name: "{{ item }}"
    state: present
    update_cache: yes
  loop:
    - git
    - curl
    - vim
```

### Meaning
This runs the same task three times:
- install git
- install curl
- install vim

---

## 12. Loop variable `item`

In a loop, the current value is usually available as:

```yaml
{{ item }}
```

Example:

```yaml
- name: Print user names
  ansible.builtin.debug:
    msg: "User name is {{ item }}"
  loop:
    - alice
    - bob
    - charlie
```

---

## 13. Loop with dictionaries

You can also loop through dictionaries.

```yaml
- name: Create users
  ansible.builtin.user:
    name: "{{ item.name }}"
    state: present
  loop:
    - { name: "alice" }
    - { name: "bob" }
    - { name: "charlie" }
```

---

## 14. Loop with multiple attributes

```yaml
- name: Create users with shell
  ansible.builtin.user:
    name: "{{ item.name }}"
    shell: "{{ item.shell }}"
    state: present
  loop:
    - name: alice
      shell: /bin/bash
    - name: bob
      shell: /bin/sh
```

### Meaning
- create user `alice` with `/bin/bash`
- create user `bob` with `/bin/sh`

---

## 15. Loop with files

```yaml
- name: Create multiple directories
  ansible.builtin.file:
    path: "{{ item }}"
    state: directory
    mode: '0755'
  loop:
    - /opt/app
    - /opt/app/logs
    - /opt/app/config
```

---

## 16. Combining loops and conditionals

You can use `loop` and `when` together.

```yaml
- name: Install packages only on Debian
  ansible.builtin.apt:
    name: "{{ item }}"
    state: present
  loop:
    - git
    - curl
    - vim
  when: ansible_os_family == "Debian"
```

### Meaning
Loop runs only if the host is Debian-based.

---

## 17. Practical example: install packages and create users

```yaml
---
- hosts: all
  become: true
  vars:
    packages:
      - git
      - curl
      - vim

    users:
      - alice
      - bob
      - charlie

  tasks:
    - name: Install required packages on Debian
      ansible.builtin.apt:
        name: "{{ item }}"
        state: present
        update_cache: yes
      loop: "{{ packages }}"
      when: ansible_os_family == "Debian"

    - name: Create users
      ansible.builtin.user:
        name: "{{ item }}"
        state: present
      loop: "{{ users }}"
```

---

## 18. Practical example: OS-specific web package

```yaml
---
- hosts: all
  become: true
  vars:
    debian_package: apache2
    redhat_package: httpd

  tasks:
    - name: Install Apache on Debian systems
      ansible.builtin.apt:
        name: "{{ debian_package }}"
        state: present
        update_cache: yes
      when: ansible_os_family == "Debian"

    - name: Install Apache on RedHat systems
      ansible.builtin.yum:
        name: "{{ redhat_package }}"
        state: present
      when: ansible_os_family == "RedHat"
```

---

## 19. Practical example: create multiple config files

```yaml
---
- hosts: all
  become: true
  tasks:
    - name: Create config files
      ansible.builtin.copy:
        dest: "/tmp/{{ item }}"
        content: "This is {{ item }}"
        mode: '0644'
      loop:
        - app.conf
        - db.conf
        - web.conf
```

---

## 20. Common loop use cases

Loops are often used for:
- package installation
- user creation
- directory creation
- copying many files
- creating firewall rules
- provisioning multiple resources

---

## 21. Best practices

### 1. Use loops to reduce repeated tasks
Do not write the same task many times if only the item changes.

### 2. Use meaningful variable names
Example:
- `packages`
- `users`
- `directories`

### 3. Use conditionals carefully
Avoid overly complex `when` conditions unless needed.

### 4. Prefer readable logic
Keep playbooks easy to understand.

### 5. Test conditionals with facts
Many `when` conditions depend on gathered facts like:
- `ansible_os_family`
- `ansible_distribution`
- `ansible_hostname`

---

## 22. Simple summary

### Conditionals
Used to control whether a task runs.

Keyword:
```yaml
when:
```

### Loops
Used to repeat a task for multiple items.

Keyword:
```yaml
loop:
```

### Together
Conditionals and loops make Ansible playbooks dynamic and reusable.

---

## 23. One-line memory

**Conditionals decide whether a task should run, and loops decide how many times it should run.**
