# 05 - VPC Networking Project: EC2 + NACL + Security Group

This document demonstrates a hands-on AWS project where a custom **VPC**, **EC2**, **NACL**, and **Security Group** were configured to securely host a **Python application**.

---

## ✅ Project Overview

### Goal

To create a fully functional virtual network using AWS VPC, configure subnets, route tables, EC2 instance, and secure it using NACLs and Security Groups.
![arch.png](../Images/vpc_network_project/arch.png)

---

## 📌 Step-by-Step Implementation

### 1. VPC Creation

- Created a VPC with CIDR: `10.0.0.0/16` (Total: 65,536 IPs)
- Enabled DNS Hostnames and DNS Resolution

### 2. Subnet Creation

- **Region 1**: 2 Public Subnets (`10.0.1.0/24`, `10.0.2.0/24`)
- **Region 2**: 2 Private Subnets (`10.0.3.0/24`, `10.0.4.0/24`)
- Enabled "Auto-assign Public IPv4 address" for public subnets

### 3. Internet Gateway

- Created and attached IGW to the VPC

### 4. Route Tables

- Created 4 route tables (2 public, 2 private)
- Associated subnets accordingly
![vpc.png](../Images/vpc_network_project/vpc.png)

### 5. EC2 Instance

- Launched EC2 instance (Amazon Linux / Ubuntu)
- Attached to Public Subnet 1 (e.g., `10.0.1.0/24`)
- Enabled auto-assigned **Public IP**
![instanct.png](../Images/vpc_network_project/instanct.png)

---

## 🐍 Python Application Setup

- SSH into EC2 instance
- Installed Python and created a basic HTTP server

```bash
python3 -m http.server 9000
```
![session.png](../Images/vpc_network_project/session.png)

- Tried accessing `http://<EC2_Public_IP>:9000` from browser

![browsr.png](../Images/vpc_network_project/browsr.png)

Initially, access **denied** due to default security restrictions.

---

## 🔐 Security Configuration

### A. NACL Inbound Rule

- Edited NACL associated with subnet to allow **port 9000** inbound from `0.0.0.0/0`
- Also added outbound rule to allow ephemeral ports (1024-65535)
![NACL.png](../Images/vpc_network_project/NACL.png)

### B. Security Group Inbound Rule

- Edited security group associated with EC2 instance
- Allowed inbound TCP traffic on **port 9000** from `0.0.0.0/0`
![SG.png](../Images/vpc_network_project/SG.png)

✅ Now, browser can successfully access the application at: `http://<Public-IP>:9000`
![brwsr.png](../Images/vpc_network_project/brwsr.png)

---

## 🔎 Important Concepts

| Concept            | Description                                                                |
| ------------------ | -------------------------------------------------------------------------- |
| **VPC**            | Isolated network space for deploying AWS resources                         |
| **Subnet**         | Division within a VPC for organizing resources (Public / Private)          |
| **NACL**           | Subnet-level stateless firewall. Controls inbound/outbound rules           |
| **Security Group** | Instance-level stateful firewall. Defines allowed inbound/outbound traffic |
| **CIDR**           | IP range defined for VPC or Subnet (e.g., `10.0.0.0/16`, `10.0.1.0/24`)    |

---

## 💡 Learning Outcome

- Understood VPC architecture and components
- Implemented networking and security best practices
- Differentiated between NACL and Security Group functionality

---

## ✅ Summary

> A complete end-to-end setup to understand how cloud networking and security controls work in real AWS environments. This project can be reused as a foundational template for deploying containerized or scalable applications.

---