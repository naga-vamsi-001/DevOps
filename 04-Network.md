
# 🌐 OSI Model and Communication Flow

This document explains the **OSI Model**, **DNS Resolution**, **TCP Handshake**, and how your browser communicates with a server using the **7 layers of networking**.

---

## 📶 Step-by-Step: Web Request Flow

1. **User types a URL** in the browser (e.g., `https://google.com`)
2. **DNS resolution** happens — domain name → IP address
3. **TCP 3-way handshake** establishes a reliable connection
4. Browser sends an **HTTP request**
5. Data flows through **7 OSI layers**, hits the server
6. Server sends back a response (HTML, CSS, JS, etc.)
7. Data flows back through the 7 layers and is rendered in the browser

---

## 🔍 What is DNS Resolution?

**DNS (Domain Name System) resolution** translates human-readable domains like `www.google.com` into machine-readable IP addresses like `142.250.64.142`.

**Steps:**
- Browser/OS cache
- DNS Resolver (ISP)
- Root DNS → TLD → Authoritative Name Server
- IP returned to browser

Command to test:
```bash
dig www.google.com
```

---

## 🤝 What is TCP Handshake?

The **TCP 3-way handshake** ensures a reliable connection before transmitting data:

1. `SYN` – Client → Server (start request)
2. `SYN-ACK` – Server → Client (acknowledge)
3. `ACK` – Client → Server (confirm)

> After this, data transmission begins.

### 🔚 TCP 4-Way Handshake (Connection Termination)
1. `FIN` → `ACK`
2. `FIN` → `ACK`

---

## 🧱 OSI Model: 7 Layers of Networking

| Layer | Name         | Function                                     | Example                      |
|-------|--------------|----------------------------------------------|------------------------------|
| 7     | Application  | App-level protocols                          | HTTP, DNS, FTP               |
| 6     | Presentation | Encoding, encryption                         | SSL/TLS, JPEG                |
| 5     | Session      | Start/end communication sessions             | TLS handshake, RPC           |
| 4     | Transport    | Reliable delivery, segmentation              | TCP/UDP                      |
| 3     | Network      | Routing and addressing                       | IP, ICMP                     |
| 2     | Data Link    | Physical addressing                          | MAC, Ethernet, ARP           |
| 1     | Physical     | Hardware transmission                        | Cables, radio, fiber optics  |

---

## 🛠 Tools to Explore

- `ping` – test reachability
- `traceroute` – track packet path
- `netstat`, `ss` – view connection states
- `dig`, `nslookup` – DNS lookup tools

---
