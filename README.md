# AWS_Three_Tier_Web_App

# Designing Robust Web Application Architecture on AWS

This repository contains the architecture plan, deployment guide, and setup scripts for building a highly available, multi-AZ 3-tier web application architecture on AWS.

## Architecture Highlights
* **Networking:** Custom VPC with 2 Public Subnets, 2 Private Application Subnets, and 2 Private Database Subnets across two Availability Zones (`us-east-1a` and `us-east-1b`).
* **Traffic Routing & Load Balancing:** Route 53 DNS routing request to an Internet-Facing Application Load Balancer (ALB).
* **Compute Layer:** Bastion/Jump Host in public subnet for secure SSH access; Apache & PHP Web Servers in private subnets with Session Stickiness enabled.
* **Database Layer:** Multi-AZ AWS RDS MySQL instance running in isolated private database subnets with access restricted to the application security group.

---

## Quick Setup Guide

### Part 1: Networking & Infrastructure
1. Create VPC `awsProject-vpc` (`20.0.0.0/16` or `/20`).
2. Set up subnets, Internet Gateway (`my-igw`), Elastic IP, and NAT Gateway (`my-nat`).
3. Configure route tables (`route-web`, `route-app`, `route-db`) and associate subnets and gateways accordingly.

### Part 2: Compute & Application Layer
1. Launch Bastion/Jump host in `web-pub-sub1`.
2. Launch `app-server1` and `app-server2` in private app subnets.
3. Transfer SSH private key to Jump Host using SCP:
   ```bash
   scp -i <key.pem> <key.pem> ec2-user@<jump-server-public-ip>:~
