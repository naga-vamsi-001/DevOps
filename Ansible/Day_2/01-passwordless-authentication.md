# 01 - Passwordless Authentication

## What is passwordless authentication?

Passwordless authentication means logging in to a remote server **without typing the account password each time**.

In Linux and DevOps, this usually means **SSH key-based authentication**.

Instead of using:

- username + password

you use:

- **private key** on the client/control node
- **public key** on the remote/managed node

---

## Why passwordless authentication is used

It helps with:

- better security than passwords
- automation
- Ansible connectivity
- avoiding repeated password prompts
- reducing brute-force risk

This is very common in:

- Linux server administration
- AWS EC2 access
- Ansible control node to managed node communication

---

## Main server authentication methods

Common ways to authenticate to a server are:

1. **Password-based authentication**
2. **SSH key-based authentication**
3. **MFA / keyboard-interactive authentication**
4. **LDAP / Active Directory / Kerberos**
5. **Certificate or token-based authentication**

For Day 2 DevOps learning, the most important one is:

- **SSH key-based authentication**

---

## SSH key pair basics

An SSH key pair has **2 parts**:

### 1. Private key
- stays on your local machine
- secret
- should never be shared

Examples:
- `id_rsa`
- `id_ed25519`
- `mykey.pem`
- `mykey.ppk`

### 2. Public key
- copied to the remote server
- stored in:

```bash
~/.ssh/authorized_keys
```

Examples:
- `id_rsa.pub`
- `id_ed25519.pub`

---

## SSH key algorithms

Common SSH key algorithms:

- **RSA**
- **Ed25519**
- **ECDSA**
- **DSA** (old/legacy)

---

## .pem vs .ppk

These are **file formats**, not separate authentication methods.

### `.pem`
- common in Linux/OpenSSH/AWS
- often used for EC2 login
- usually represents a private key file

Example:

```bash
ssh -i mykey.pem ubuntu@server_ip
```

### `.ppk`
- PuTTY private key format
- mainly used on Windows with PuTTY

---

## How SSH key-based login works

```text
Client / Control Node                        Managed Node / Server
---------------------                        ---------------------
Private Key                                  Public Key
(id_rsa / id_ed25519 / .pem)                (~/.ssh/authorized_keys)

        |                                               |
        |------ SSH login request --------------------->|
        |                                               |
        |<----- Server checks matching public key ------|
        |                                               |
        |------ Client proves private key ownership --->|
        |                                               |
        |<----- Login allowed if keys match ------------|
```

---

## Steps to set up passwordless authentication

### Step 1: Generate SSH key pair

```bash
ssh-keygen
```

This creates files like:

```bash
~/.ssh/id_rsa
~/.ssh/id_rsa.pub
```

or

```bash
~/.ssh/id_ed25519
~/.ssh/id_ed25519.pub
```

---

### Step 2: Copy public key to the server

```bash
ssh-copy-id user@server_ip
```

This command copies the **public key** to the remote server’s:

```bash
~/.ssh/authorized_keys
```

---

### Step 3: Log in without typing password

```bash
ssh user@server_ip
```

If the key is correctly configured, login happens without asking for the user password.

---

## `ssh-copy-id` vs `ssh -i`

These are different.

### `ssh-copy-id`
Used to **copy your public key to the server**.

Example:

```bash
ssh-copy-id user@server_ip
```

Purpose:
- setup passwordless SSH
- copies public key into `authorized_keys`

---

### `ssh -i`
Used to **tell SSH which private key to use for login**.

Example:

```bash
ssh -i mykey.pem user@server_ip
```

Purpose:
- authenticate using a specific private key file

---

## Easy difference

- **`ssh-copy-id`** = copies the **public key** to the server
- **`ssh -i`** = uses the **private key** to log in

---

## Why AWS EC2 usually does not use password login

For Linux EC2 instances, AWS usually sets up access using **SSH key pairs**, not regular passwords.

Reasons:

- more secure
- avoids password guessing/brute force
- AWS injects the public key at launch
- you keep the matching `.pem` private key

Typical login:

```bash
ssh -i mykey.pem ubuntu@<public-ip>
```

---

## Why EC2 works with SSH key

At instance launch:

1. AWS places the **public key** on the EC2 instance
2. You download the **private key** (`.pem`)
3. SSH compares the private key to the stored public key
4. If they match, login succeeds

---

## Can EC2 use password authentication?

Yes, but usually not by default for Linux EC2.

If needed, you can manually enable it:

1. log in using `.pem`
2. enable `PasswordAuthentication yes`
3. set a password for the user
4. then optionally use that password to run `ssh-copy-id`

---

## Example flow using password temporarily

### Initial login with EC2 private key

```bash
ssh -i <path-to-pem> ubuntu@<public-ip>
```

### Enable password authentication
Edit:

```bash
/etc/ssh/sshd_config.d/60-cloudimg-settings.conf
```

Set:

```text
PasswordAuthentication yes
```

Then set password:

```bash
sudo passwd ubuntu
```

---

### Use password once with `ssh-copy-id`

```bash
ssh-copy-id ubuntu@<public-ip>
```

You enter the password once.

This copies your local machine’s **public key** to the server.

---

### Future login

```bash
ssh ubuntu@<public-ip>
```

Now login works without typing password.

### Important note
This is **not passwordless login using password**.

Correct explanation:

- password was used **one time** to copy the public key
- future access happens using **SSH key-based authentication**

---

## Why login may work without writing `-i`

This can happen if:

1. the key is in default location like:
   - `~/.ssh/id_rsa`
   - `~/.ssh/id_ed25519`

2. SSH config file is set:

```bash
~/.ssh/config
```

Example:

```text
Host myserver
    HostName <public-ip>
    User ubuntu
    IdentityFile ~/.ssh/id_rsa
```

3. the key is loaded into `ssh-agent`

---

## Ansible and passwordless authentication

Ansible commonly uses SSH passwordless login between:

- **control node**
- **managed nodes**

Why?

Because Ansible needs to connect automatically to many servers.

If password is required every time, automation becomes difficult.

Typical model:

- control node has private key
- public key is copied to managed nodes
- Ansible connects over SSH without password prompt

---

## Key points to remember

- Passwordless authentication in DevOps usually means **SSH key-based login**
- SSH keys come in **private key** and **public key**
- `ssh-copy-id` copies the **public key**
- `ssh -i` uses the **private key**
- `.pem` and `.ppk` are **formats**
- EC2 Linux instances usually use **SSH keys**, not passwords
- Password can be used one time to help install a public key, but final passwordless login still uses **SSH keys**

---

## Short summary

Passwordless authentication is a secure method to access servers without typing a password each time. In Linux and Ansible environments, this is usually done with SSH public/private key pairs. The public key is stored on the remote server, while the private key stays on the local machine. Once configured, login works without repeated password prompts, which makes automation and server administration easier.
