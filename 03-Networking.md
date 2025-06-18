## 📡 Networking Basics for DevOps

This file contains core concepts, definitions, real-world examples, and structured learning for foundational networking used in DevOps and cloud computing.

---

### 📍 1. What is an IP Address?
An **IP address** is a unique identifier assigned to every device connected to a network. It enables devices to communicate with each other.

- **IPv4 Example:** `192.168.1.10` (4 octets, range 0–255)
- **IPv6 Example:** `2001:0db8:85a3::8a2e:0370:7334`

---

### 🔢 2. Types of IP Addresses
| Type        | Example         | Usage                    |
|-------------|------------------|---------------------------|
| **Public**  | 173.194.39.78    | Globally reachable (internet) |
| **Private** | 192.168.x.x      | Internal use only         |

**Private IP Ranges:**
- `10.0.0.0` – `10.255.255.255`
- `172.16.0.0` – `172.31.255.255`
- `192.168.0.0` – `192.168.255.255`

---

### 🧩 3. What is a Port?
A **port** is a logical connection point for specific services on a device.

- **HTTP:** Port 80
- **HTTPS:** Port 443
- **SSH:** Port 22

It allows a single IP to host multiple services. Think of ports like **doors into your house**.

---

### 🌐 4. What is a Subnet?
A **subnet** is a smaller network within a larger network (IP block) used to isolate and manage traffic.

---

### 🔢 5. What is CIDR (Classless Inter-Domain Routing)?
CIDR is a method for allocating IP addresses and routing. It replaces the old class-based system.

**CIDR Notation Example:** `172.2.3.0/24`

- `172.2.3.0` is the network address
- `/24` means the first 24 bits are fixed as network bits
- The remaining 8 bits are available for host addresses (2^8 = 256 IPs)

This gives you usable host addresses from `172.2.3.1` to `172.2.3.254`

### 🧮 Breakdown:
- IP address = 32 bits total (4 bytes × 8 bits)
- `/24` = First 3 bytes fixed (172.2.3), 1 byte for host (0–255)
- Total = 256 IP addresses

> Common subnet sizes:
> - `/24` = 256 IPs
> - `/25` = 128 IPs
> - `/26` = 64 IPs

---

### 🧱 6. Subnet Features
#### ✅ Security, Privacy, and Isolation
- **Security:** Restrict access between services using subnets
- **Privacy:** Place sensitive services in private subnets
- **Isolation:** Separate public and private traffic

| Feature      | Public Subnet       | Private Subnet        |
|--------------|----------------------|------------------------|
| Internet     | Yes                  | No (via NAT required) |
| Use Case     | Web servers          | Databases, internal apps |
| Exposure     | High                 | Low                   |

---

### 🛠 7. VPC (Virtual Private Cloud)
A **VPC** is a private, isolated virtual network in cloud providers like AWS.

- You define CIDR block (e.g., `10.0.0.0/16`)
- Divide it into **subnets** (e.g., `10.0.1.0/24`, `10.0.2.0/24`)
- Add routing, internet gateways, NAT, and security groups

> Think of a VPC like a **virtual data center** you fully control.

---

### 🛣 8. What is a Hop?
Each router a packet crosses from source to destination is called a **hop**.

`traceroute google.com` shows all the hops it takes to reach Google. Example:
```
1 192.168.1.1     (Home Router)
2 10.0.0.1        (ISP Gateway)
3 * * *           (Dropped or Firewalled hop)
4 142.250.64.142  (Google)
```

---

### 🌍 9. NAT and NAT Mode
**NAT (Network Address Translation)** allows private IPs to connect to the internet using a shared public IP.

- Used in home routers, cloud VPCs
- NAT **hides internal network structure**

**NAT Mode in VMs** means VMs share the host's IP address for outbound internet.

---

### 🔐 10. Public vs Private IP Address
- **Public IP**: Reachable from outside the network
- **Private IP**: Used inside a network; not accessible from outside

Use `ifconfig` or `ip a` to view private IP of VM.
Use `curl ifconfig.me` to get public IP from terminal.

---

### 🚪 11. Ports Summary Table
| Port | Protocol | Description         |
|------|----------|---------------------|
| 22   | SSH      | Remote terminal     |
| 80   | HTTP     | Web (unencrypted)   |
| 443  | HTTPS    | Web (secure)        |
| 3306 | MySQL    | Database            |

---
