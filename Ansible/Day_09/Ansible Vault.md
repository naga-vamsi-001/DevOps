## What is Ansible Vault?

Ansible Vault is an Ansible feature used to encrypt sensitive data so it is not stored in plain text.

It is mainly used to protect:
- passwords
- API keys
- access tokens
- database credentials
- secret variables

Vault lets you keep secrets inside an Ansible project more safely, including in Git, as long as the vault password is protected.

---

## Why use Ansible Vault?

In Ansible projects, variables are often stored in places like:
- `group_vars/`
- `host_vars/`
- role variable files
- separate secrets files

If secrets are written directly in those files, anyone with access to the files can read them.

Example of unsafe plain text:

```yaml
db_user: admin
db_password: mypassword123
aws_secret_key: ABCXYZ123
```

Ansible Vault solves this by encrypting sensitive content.

---

## How Ansible Vault works

Vault encrypts file content so it becomes unreadable without the correct vault password.

Encrypted content looks like this:

```text
$ANSIBLE_VAULT;1.1;AES256
61393831393764656362356630313964643863616234386639633963323939613932353166636661
...
```

When you run a playbook and provide the vault password, Ansible decrypts the content at runtime and uses it.

---

## Common uses of Ansible Vault

Ansible Vault is commonly used for:
- encrypted variable files
- encrypted group variables
- encrypted host variables
- encrypted task files
- encrypted strings

Most often, it is used for secret variable files.

---

## Encrypting and decrypting files

### Create a new encrypted file

```bash
ansible-vault create secret.yml
```

This asks for a vault password and opens an editor so you can add content.

Example:

```yaml
db_user: admin
db_password: SuperSecret123
```

After saving, the file is stored in encrypted form.

### View an encrypted file

```bash
ansible-vault view secret.yml
```

### Edit an encrypted file

```bash
ansible-vault edit secret.yml
```

### Encrypt an existing file

```bash
ansible-vault encrypt secret.yml
```

### Decrypt a file

```bash
ansible-vault decrypt secret.yml
```

### Change the vault password

```bash
ansible-vault rekey secret.yml
```

---

## Using Vault in a playbook

Suppose `secret.yml` contains encrypted variables.

Example playbook:

```yaml
---
- hosts: all
  become: true
  vars_files:
    - secret.yml

  tasks:
    - name: Print database user
      ansible.builtin.debug:
        msg: "Database user is {{ db_user }}"
```

Run it with:

```bash
ansible-playbook site.yml --ask-vault-pass
```

Ansible will prompt for the vault password, decrypt the file during execution, and use the variables.

---

## Using a vault password file

Instead of typing the password every time, you can use a password file:

```bash
ansible-playbook site.yml --vault-password-file ~/.vault_pass.txt
```

This is useful for automation, but the password file itself must be protected carefully.

---

## Encrypting a single string

You can encrypt only one value instead of the whole file.

Example:

```bash
ansible-vault encrypt_string 'SuperSecret123' --name 'db_password'
```

This produces encrypted output that can be placed inside a normal YAML file.

Example:

```yaml
db_user: admin
db_password: !vault |
          $ANSIBLE_VAULT;1.1;AES256
          333761646536343936333733343936...
```

This is useful when only a few values are secret.

---

## Common Ansible Vault commands

```bash
ansible-vault create secret.yml
ansible-vault view secret.yml
ansible-vault edit secret.yml
ansible-vault encrypt secret.yml
ansible-vault decrypt secret.yml
ansible-vault rekey secret.yml
ansible-vault encrypt_string 'mypassword' --name 'db_password'
ansible-vault create secrey.yml --vault-password-file vault.pass
```

---

## Summary

Ansible Vault is used to secure sensitive data in Ansible by encrypting files or variable values. It helps protect secrets like passwords, tokens, and credentials while still allowing Ansible to use them during playbook execution.
