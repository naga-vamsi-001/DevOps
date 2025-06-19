## 📡 Networking Basics for DevOps

This file contains core concepts, definitions, real-world examples, and structured learning for foundational networking used in DevOps and cloud computing.

---

### 📍 1. What is an IP Address?
An **IP address** is a unique identifier assigned to every device connected to a network. It enables devices to communicate with each other.

- **IPv4 Example:** `192.168.1.10`   (4 octets, range 0–255)
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

> Think of ports like **doors into your house**.

---

### 🟡 4. What is DHCP?
DHCP (Dynamic Host Configuration Protocol) is a network management protocol used to **automatically assign IP addresses** and other communication parameters to devices on a network.

- **Purpose**: Automates IP address assignment
- **Example**: When you launch an EC2 instance, DHCP assigns a private IP

---

### 🛣 5. What is a Hop?
Each router a packet crosses from source to destination is called a **hop**.

Example:
```bash
traceroute google.com
```
Result:
```
1 192.168.1.1     (Home Router)
2 10.0.0.1        (ISP Gateway)
3 * * *           (Dropped or Firewalled hop)
4 142.250.64.142  (Google)
```

---

### 🛠 6. What is a VPC (Virtual Private Cloud)?
A **VPC** is a private, isolated virtual network in cloud providers like AWS.

- You define a CIDR block (e.g., `10.0.0.0/16`)
- Divide into **subnets** (e.g., `10.0.1.0/24`, `10.0.2.0/24`)
- Add routing, Internet Gateways, NAT, and Security Groups

> Think of a VPC like a **virtual data center** you fully control.

---

### 🔢 7. What is CIDR (Classless Inter-Domain Routing)?
CIDR is a method for allocating IP addresses and routing. It replaces the older class-based system.

**Example:** `172.2.3.0/24`
- `/24` → First 24 bits are network, remaining 8 bits for host (256 IPs)

> Common subnet sizes:
> - `/24` = 256 IPs
> - `/25` = 128 IPs
> - `/26` = 64 IPs

---

### 🧱 8. What is a Subnet?
A subnet divides the IP address range of a VPC into smaller segments.

- **Public Subnet**: Has route to internet via IGW
- **Private Subnet**: No direct internet access

| Feature      | Public Subnet       | Private Subnet        |
|--------------|----------------------|------------------------|
| Internet     | Yes                  | No (via NAT required) |
| Use Case     | Web servers          | Databases, internal apps |
| Exposure     | High                 | Low                   |

---

### 🌍 9. What is NAT and NAT Mode?
**NAT (Network Address Translation)** allows private IPs to access the internet using a shared public IP.

- Used in home routers, cloud VPCs
- NAT hides internal network structure

**NAT Mode in VMs** means VMs share the host's IP address for outbound internet access.

---

### 🔐 10. Public vs Private IP Address
- **Public IP**: Reachable from outside the network
- **Private IP**: Internal use only

Check via:
```bash
ifconfig or ip a       # Shows private IP
curl ifconfig.me       # Shows public IP
```

---

### 🌐 11. What is an Internet Gateway (IGW)?
An **Internet Gateway** is a gateway attached to a VPC that enables communication between your resources and the public internet.

- Needed for public subnets to access internet

---

### 🧭 12. What is a Route Table?
A route table defines how traffic is directed in a VPC.

- Public subnet → `0.0.0.0/0` via IGW
- Private subnet → route via NAT or remain internal

---

### 🔒 13. What is a Security Group?
A **Security Group** is a virtual firewall that works at the **instance level** (stateful).

- Inbound rules must be explicitly allowed
- Outbound traffic is allowed by default

---

### 🚧 14. What is a NACL (Network Access Control List)?
A **NACL** is a stateless firewall operating at the **subnet level**.

- Must explicitly allow **both** inbound and outbound rules
- Does **not** automatically allow return traffic

---

### 🔄 15. Inbound vs Outbound Traffic
- **Inbound**: Traffic *coming into* an instance (e.g., user accessing web app)
- **Outbound**: Traffic *going out* of an instance (e.g., app accessing DB)

---

## ✅ Summary Points

- IP, Port, and DHCP form the **base** of network communication
- VPC, Subnets, and Route Tables define **virtual networking**
- NAT, IGW, Security Groups, and NACLs **secure and control** traffic
- Public vs Private IPs clarify **external vs internal reachability**