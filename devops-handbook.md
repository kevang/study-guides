# DevOps Handbook

## Table of Contents

### Part I: Linux

#### 1. User and Group Management
* [User Accounts](#user-accounts)
* [Group Management](#group-management)
* [sudo Configuration](#sudo-configuration)
* [PAM and Authentication](#pam-and-authentication)
* [SSH Key Authentication](#ssh-key-authentication)

#### 2. Disk Partitioning and LVM
* [Partitioning with fdisk and parted](#partitioning-with-fdisk-and-parted)
* [Logical Volume Manager (LVM)](#logical-volume-manager-lvm)
* [Filesystem Creation and Mounting](#filesystem-creation-and-mounting)
* [RAID Configuration](#raid-configuration)

#### 3. Systemd and systemctl
* [systemd Unit Files](#systemd-unit-files)
* [Managing Services](#managing-services)
* [Targets and Boot](#targets-and-boot)
* [Timers and Scheduled Tasks](#timers-and-scheduled-tasks)
* [systemd Troubleshooting](#systemd-troubleshooting)

#### 4. Log Management
* [journald and journalctl](#journald-and-journalctl)
* [Traditional Syslog](#traditional-syslog)
* [logrotate Configuration](#logrotate-configuration)
* [Centralized Logging](#centralized-logging)

#### 5. Network Tools
* [ip and ss Commands](#ip-and-ss-commands)
* [DNS Tools: dig, host, nslookup](#dns-tools-dig-host-nslookup)
* [Network Testing: ping, traceroute, mtr](#network-testing-ping-traceroute-mtr)
* [Port Scanning: nmap](#port-scanning-nmap)
* [tcpdump and Wireshark](#tcpdump-and-wireshark)

#### 6. Process Management
* [Process Lifecycle and States](#process-lifecycle-and-states)
* [Process Inspection Tools](#process-inspection-tools)
* [Process Groups, Sessions, and Daemonization](#process-groups-sessions-and-daemonization)
* [Signals and Signal Handling](#signals-and-signal-handling)
* [Process Debugging with strace and gdb](#process-debugging-with-strace-and-gdb)

#### 7. Memory Management
* [Virtual Memory and Paging](#virtual-memory-and-paging)
* [Memory Monitoring Tools](#memory-monitoring-tools)
* [The OOM Killer](#the-oom-killer)
* [Huge Pages and Memory Cgroups](#huge-pages-and-memory-cgroups)
* [Swap Configuration](#swap-configuration)

#### 8. Filesystem
* [VFS Layer](#vfs-layer)
* [Inodes, Links, and File Attributes](#inodes-links-and-file-attributes)
* [Filesystem Types: ext4, xfs, btrfs](#filesystem-types-ext4-xfs-btrfs)
* [IO Scheduling](#io-scheduling)
* [Virtual Filesystems: /proc and /sys](#virtual-filesystems-proc-and-sys)

#### 9. Networking
* [Network Namespaces](#network-namespaces)
* [iptables and nftables](#iptables-and-nftables)
* [eBPF and bpftrace](#ebpf-and-bpftrace)
* [TCP/IP Stack Internals](#tcpip-stack-internals)
* [Network Tuning with sysctl](#network-tuning-with-sysctl)

#### 10. Boot and Init Systems
* [Boot Process](#boot-process)
* [systemd Deep Dive](#systemd-deep-dive)
* [cgroups v2 and Resource Control](#cgroups-v2-and-resource-control)
* [Container Runtimes](#container-runtimes)

#### 11. Shell and Scripting
* [Bash Internals](#bash-internals)
* [Text Processing: sed, awk, find](#text-processing-sed-awk-find)
* [Here Documents and Strings](#here-documents-and-strings)
* [Error Handling in Scripts](#error-handling-in-scripts)
* [Shell Performance](#shell-performance)

#### 12. Linux Hardening and Audit
* [sysctl Security Tuning](#sysctl-security-tuning)
* [SELinux and AppArmor](#selinux-and-apparmor)
* [PAM Configuration](#pam-configuration)
* [auditd Rules and Log Analysis](#auditd-rules-and-log-analysis)
* [File Permissions and ACLs](#file-permissions-and-acls)

### Part II: Networking

#### 13. Transport Layer
* [TCP: Three-Way Handshake and Sliding Window](#tcp-three-way-handshake-and-sliding-window)
* [TCP Congestion Control](#tcp-congestion-control)
* [UDP and When to Use It](#udp-and-when-to-use-it)
* [Socket Options and Tuning](#socket-options-and-tuning)

#### 14. Application Layer
* [DNS: Resolution and Records](#dns-resolution-and-records)
* [HTTP/1.1, HTTP/2, and HTTP/3](#http11-http2-and-http3)
* [Load Balancing Algorithms](#load-balancing-algorithms)
* [CDN and Caching](#cdn-and-caching)

#### 15. Network Security
* [TLS/SSL Handshake](#tlsssl-handshake)
* [Mutual TLS (mTLS)](#mutual-tls-mtls)
* [SSH Tunneling and Port Forwarding](#ssh-tunneling-and-port-forwarding)
* [VPN Protocols](#vpn-protocols)

#### 16. High Availability and Load Balancing
* [HAProxy Deep Dive](#haproxy-deep-dive)
* [NGINX Load Balancing](#nginx-load-balancing)
* [Health Checks](#health-checks)
* [Circuit Breakers](#circuit-breakers)
* [Rate Limiting](#rate-limiting)

### Part III: Cryptography

#### 17. Cryptographic Primitives
* [Symmetric Encryption: AES](#symmetric-encryption-aes)
* [Asymmetric Encryption: RSA, ECDH, Ed25519](#asymmetric-encryption-rsa-ecdh-ed25519)
* [Hashing: SHA-2, SHA-3, bcrypt, Argon2](#hashing-sha-2-sha-3-bcrypt-argon2)
* [MACs and HMACs](#macs-and-hmacs)
* [Entropy and Randomness](#entropy-and-randomness)

#### 18. PKI and Certificates
* [X.509 Certificate Structure](#x509-certificate-structure)
* [Certificate Chains and CA Hierarchy](#certificate-chains-and-ca-hierarchy)
* [CSR Generation and Self-Signed Certificates](#csr-generation-and-self-signed-certificates)
* [Certificate Rotation and ACME](#certificate-rotation-and-acme)
* [CRL vs OCSP](#crl-vs-ocsp)

#### 19. Secrets Management
* [HashiCorp Vault: Transit Secrets](#hashicorp-vault-transit-secrets)
* [Vault PKI and Dynamic Secrets](#vault-pki-and-dynamic-secrets)
* [Kubernetes Secrets](#kubernetes-secrets)
* [Cloud Secret Managers](#cloud-secret-managers)
* [SOPS and age Encryption](#sops-and-age-encryption)

### Part IV: Containerization

#### 20. Docker Deep Dive
* [Container Runtime Internals](#container-runtime-internals)
* [Docker Daemon and containerd](#docker-daemon-and-containerd)
* [Image Layers and Storage Drivers](#image-layers-and-storage-drivers)
* [BuildKit and Multi-Stage Builds](#buildkit-and-multi-stage-builds)
* [Docker Networking](#docker-networking)
* [Volumes and Bind Mounts](#volumes-and-bind-mounts)
* [Container Security](#container-security)

#### 21. Docker Compose
* [Compose File Syntax](#compose-file-syntax)
* [Service Dependencies and Healthchecks](#service-dependencies-and-healthchecks)
* [Networking Between Containers](#networking-between-containers)
* [Resource Limits and Restart Policies](#resource-limits-and-restart-policies)

### Part V: Kubernetes

#### 22. Kubernetes Architecture
* [Control Plane Components](#control-plane-components)
* [Worker Nodes and Kubelet](#worker-nodes-and-kubelet)
* [Pod Lifecycle](#pod-lifecycle)
* [Labels, Selectors, and Annotations](#labels-selectors-and-annotations)

#### 23. Workload Resources
* [Deployments: Rolling Updates and Rollbacks](#deployments-rolling-updates-and-rollbacks)
* [StatefulSets](#statefulsets)
* [DaemonSets](#daemonsets)
* [Jobs and CronJobs](#jobs-and-cronjobs)
* [ReplicaSets](#replicasets)

#### 24. Networking and Services
* [CNI Plugins](#cni-plugins)
* [Service Types](#service-types)
* [Ingress Controllers](#ingress-controllers)
* [NetworkPolicies](#networkpolicies)
* [DNS in Kubernetes](#dns-in-kubernetes)

#### 25. Configuration and Storage
* [ConfigMaps and Secrets](#configmaps-and-secrets)
* [PersistentVolumes and Claims](#persistentvolumes-and-claims)
* [StorageClasses and Dynamic Provisioning](#storageclasses-and-dynamic-provisioning)
* [CSI Drivers](#csi-drivers)

#### 26. Kubernetes Security
* [RBAC: ServiceAccounts and Roles](#rbac-serviceaccounts-and-roles)
* [Pod Security Standards](#pod-security-standards)
* [Image Scanning](#image-scanning)
* [Seccomp, AppArmor, and SELinux](#seccomp-apparmor-and-selinux)

#### 27. Helm and Package Management
* [Helm Chart Structure](#helm-chart-structure)
* [Values Files and Templating](#values-files-and-templating)
* [Hooks and Tests](#hooks-and-tests)
* [Helmfile and ArgoCD](#helmfile-and-argocd)

### Part VI: Observability

#### 28. Metrics
* [Prometheus Architecture](#prometheus-architecture)
* [PromQL Deep Dive](#promql-deep-dive)
* [Exporters](#exporters)
* [Recording Rules and Alerts](#recording-rules-and-alerts)
* [Thanos and Cortex](#thanos-and-cortex)

#### 29. Logging
* [Log Aggregation with ELK/EFK](#log-aggregation-with-elkefk)
* [Loki and LogQL](#loki-and-logql)
* [Structured Logging](#structured-logging)
* [Sampling and Retention](#sampling-and-retention)

#### 30. Distributed Tracing
* [Traces and Spans](#traces-and-spans)
* [OpenTelemetry](#opentelemetry)
* [Jaeger and Tempo](#jaeger-and-tempo)
* [Context Propagation](#context-propagation)

#### 31. Alerting and SLOs
* [Alert Design Principles](#alert-design-principles)
* [SLI, SLO, and SLA](#sli-slo-and-sla)
* [Error Budgets](#error-budgets)
* [On-Call Practices](#on-call-practices)

### Part VII: Infrastructure as Code

#### 32. Terraform
* [Provider Architecture](#provider-architecture)
* [State Management](#state-management)
* [Modules and Expressions](#modules-and-expressions)
* [Testing and Linting](#testing-and-linting)

#### 33. Ansible
* [Ansible Execution Model](#ansible-execution-model)
* [Modules vs Shell](#modules-vs-shell)
* [Roles and Playbook Structure](#roles-and-playbook-structure)
* [Jinja2 Templating](#jinja2-templating)

### Part VIII: CI/CD

#### 34. Pipeline Architecture
* [Pipeline Stages](#pipeline-stages)
* [GitHub Actions](#github-actions)
* [GitLab CI](#gitlab-ci)
* [Artifact Storage](#artifact-storage)

#### 35. GitOps
* [ArgoCD and Flux](#argocd-and-flux)
* [Drift Detection](#drift-detection)
* [Progressive Delivery](#progressive-delivery)

### Part IX: Reliability Engineering

#### 36. Caching
* [Redis and Memcached](#redis-and-memcached)
* [Cache Patterns](#cache-patterns)
* [CDN Fundamentals](#cdn-fundamentals)

#### 37. Messaging and Queues
* [Kafka: Partitions and Replication](#kafka-partitions-and-replication)
* [RabbitMQ: Exchanges and Queues](#rabbitmq-exchanges-and-queues)
* [Dead Letter Queues](#dead-letter-queues)

#### 38. Database Operations
* [Replication Strategies](#replication-strategies)
* [Connection Pooling](#connection-pooling)
* [Backups and Point-in-Time Recovery](#backups-and-point-in-time-recovery)

#### 39. API Gateways
* [Kong and NGINX Gateway](#kong-and-nginx-gateway)
* [Rate Limiting and Auth](#rate-limiting-and-auth)
* [Circuit Breaking](#circuit-breaking)

#### 40. Service Mesh
* [Istio Basics](#istio-basics)
* [Linkerd](#linkerd)

#### 41. Chaos Engineering
* [Chaos Engineering Principles](#chaos-engineering-principles)
* [Chaos Mesh and Litmus](#chaos-mesh-and-litmus)
* [Game Days](#game-days)

### Part X: Incident Management and Access

#### 42. Access and Bastion Hosts
* [SSH Key Management](#ssh-key-management)
* [Bastion Host Patterns](#bastion-host-patterns)
* [Session Recording](#session-recording)
* [Zero-Trust Access](#zero-trust-access)

#### 43. Incident Management
* [On-Call Practices](#on-call-practices-1)
* [Runbooks](#runbooks)
* [Post-Mortems](#post-mortems)
* [Severity Classification](#severity-classification)

#### 44. Disaster Recovery
* [RTO and RPO](#rto-and-rpo)
* [Backup Strategies](#backup-strategies)
* [Failover Testing](#failover-testing)

---

## Part I: Linux

## 1. User and Group Management

### User Accounts

Linux uses a user-based permission system. Each process runs as a specific user, and file permissions determine who can access what resources.

#### Creating and Managing Users

```bash
# Create a new user
useradd -m -s /bin/bash -c "Full Name" username

# Create user with specific UID
useradd -u 1500 -m username

# Set password
passwd username

# Modify user
usermod -aG sudo username    # Add to group
usermod -L username          # Lock account
usermod -U username          # Unlock account
usermod -s /bin/false username  # Disable shell access

# Delete user
userdel -r username          # Remove home directory

# View user info
id username
finger username
getent passwd username

# Password aging
# /etc/login.defs
PASS_MAX_DAYS 90
PASS_MIN_DAYS 1
PASS_WARN_AGE 7
```

#### User Database

```bash
# User information is stored in:
# /etc/passwd - user accounts
# /etc/shadow - encrypted passwords (root only)
# /etc/group - group memberships

# Format of /etc/passwd
# username:password:UID:GID:GECOS:home:shell
root:x:0:0:root:/root:/bin/bash

# Format of /etc/shadow
# username:encrypted_password:last_change:min:max:warn:inactive:expire
root:$6$xyz:19000:0:99999:7::

# Check password status
passwd -S username
```

### Group Management

Groups allow you to manage permissions for multiple users at once.

```bash
# Create group
groupadd developers

# Create group with specific GID
groupadd -g 1500 developers

# Add user to group
usermod -aG developers username

# Remove user from group
gpasswd -d username developers

# Set group password
gpasswd developers

# Delete group
groupdel developers

# List groups
getent group
groups username
```

### sudo Configuration

The sudo command allows regular users to execute commands with elevated privileges.

```bash
# Add user to sudo group (Debian/Ubuntu)
usermod -aG sudo username

# Add user to wheel group (RHEL/CentOS)
usermod -aG wheel username

# Edit sudoers file safely
visudo

# Examples of sudoers configuration:
# username ALL=(ALL:ALL) ALL
# %groupname ALL=(ALL:ALL) ALL
# username ALL=(ALL) NOPASSWD: /usr/bin/systemctl restart nginx
# Defaults:username env_keep+=HOME

# sudoers examples:
# Run all commands
username ALL=(ALL: ALL) ALL

# Run specific commands without password
username ALL=(ALL) NOPASSWD: /usr/bin/systemctl restart nginx, /usr/bin/systemctl status nginx

# Run as specific user
username ALL=(www-data) ALL

# Run as specific group
username ALL=(:www-data) /usr/bin/make install
```

### PAM and Authentication

Pluggable Authentication Modules (PAM) provide flexible authentication mechanisms.

```bash
# PAM configuration files in /etc/pam.d/
# Common PAM modules:
# pam_unix.so - traditional UNIX authentication
# pam_sss.so - SSSD/LDAP authentication
# pam_permit.so - always permit
# pam_deny.so - always deny
# pam_cap.so - capability-based auth
# pam_limits.so - resource limits

# Example: /etc/pam.d/common-auth
auth    [success=1 default=ignore]  pam_unix.so nullok_secure
auth    requisite                       pam_deny.so
auth    required                       pam_permit.so

# Example: /etc/pam.d/common-account
account [success=1 default=ignore]  pam_unix.so
account requisite                       pam_deny.so
account required                       pam_permit.so

# Example: /etc/pam.d/common-session
session required        pam_unix.so
session optional        pam_systemd.so

# Password quality requirements
# /etc/pam.d/common-password
password required pam_pwquality.so retry=3 minlen=12 dcredit=-1 ucredit=-1 lcredit=-1 ocredit=-1 difok=3 enforce_for_root

# Resource limits
# /etc/security/limits.conf
* soft nofile 65536
* hard nofile 65536
@developers soft nproc 2048
@developers hard nproc 4096
root - nofile 65536
```

### SSH Key Authentication

```bash
# Generate SSH key
ssh-keygen -t ed25519 -C "user@host"

# Or RSA (for older systems)
ssh-keygen -t rsa -b 4096 -C "user@host"

# Copy public key to server
ssh-copy-id user@server

# Manual key installation
mkdir -p ~/.ssh
chmod 700 ~/.ssh
cat ~/.ssh/id_ed25519.pub >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys

# SSH agent
ssh-add ~/.ssh/id_ed25519
ssh-add -l

# SSH config
# ~/.ssh/config
Host server1
    HostName server1.example.com
    User admin
    Port 22
    IdentityFile ~/.ssh/id_rsa_server1
    ForwardAgent yes
    ServerAliveInterval 60
    ServerAliveCountMax 3

Host *
    StrictHostKeyChecking ask
    IdentityFile ~/.ssh/id_rsa
    AddKeysToAgent yes
```

---

## 2. Disk Partitioning and LVM

### Partitioning with fdisk and parted

```bash
# List partitions
fdisk -l /dev/sda
parted -l

# Partition with fdisk
fdisk /dev/sdb
# Commands:
# n - new partition
# p - primary partition
# e - extended partition
# d - delete partition
# t - change type (Linux, Linux LVM, etc.)
# w - write and quit
# q - quit without writing

# Partition with parted (interactive)
parted /dev/sdb
(parted) mklabel gpt
(parted) mkpart primary ext4 0% 100%
(parted) quit

# Create partition types
# 0x83 - Linux
# 0x8e - Linux LVM
# 0xfd - Linux RAID auto

# Partprobe to inform kernel
partprobe /dev/sdb
```

### Logical Volume Manager (LVM)

LVM provides flexible disk management with logical volumes that can span multiple physical disks.

```bash
# Physical Volume (PV)
pvcreate /dev/sdb1 /dev/sdc1
pvdisplay
pvs

# Volume Group (VG)
vgcreate vg_data /dev/sdb1 /dev/sdc1
vgextend vg_data /dev/sdd1
vgreduce vg_data /dev/sdb1
vgdisplay
vgs

# Logical Volume (LV)
lvcreate -n lv_data -L 100G vg_data
lvcreate -n lv_data -l 100%FREE vg_data
lvcreate -n lv_data -l 50%VG vg_data
lvdisplay
lvs

# Create LV with specific extents
lvcreate -n lv_data -l 25600 vg_data  # 25600 extents

# Resize LV
lvextend -L +50G /dev/vg_data/lv_data
lvreduce -L -20G /dev/vg_data/lv_data
lvextend -l +100%FREE /dev/vg_data/lv_data

# Resize filesystem (after resizing LV)
resize2fs /dev/vg_data/lv_data    # ext4
xfs_growfs /mount/point          # xfs

# Remove LVM
lvremove /dev/vg_data/lv_data
vgremove vg_data
pvremove /dev/sdb1

# LVM snapshots
lvcreate -s -n snap_data -L 10G /dev/vg_data/lv_data
mount -o ro /dev/vg_data/snap_data /mnt/snap
lvremove /dev/vg_data/snap_data

# LVM thin provisioning
# Create thin pool
lvcreate --type thin -n thin_pool -L 100G vg_data
lvcreate -V 50G --thin vg_data/thin_pool -n thin_lv
```

### Filesystem Creation and Mounting

```bash
# Create filesystem
mkfs.ext4 /dev/sdb1
mkfs.xfs /dev/sdb1
mkfs.btrfs /dev/sdb1

# XFS options
mkfs.xfs -f -b size=4096 -d sw=4,su=64k /dev/sdb1

# btrfs options
mkfs.btrfs -d raid1 -m raid1 /dev/sdb1 /dev/sdc1

# Tune filesystem
tune2fs -c 0 -i 0 /dev/sdb1    # Disable ext4 checks (careful!)
xfs_info /mount/point

# Mount
mount /dev/sdb1 /mnt/data

# Mount with options
mount -o rw,noexec,nosuid,nodev /dev/sdb1 /mnt/data

# /etc/fstab entries
# /dev/sdb1 /mnt/data ext4 defaults 0 2
# UUID=xxx /mnt/data ext4 defaults 0 2
# /dev/vg_data/lv_data /mnt/data xfs defaults 0 2

# UUIDs
blkid /dev/sdb1
tune2fs -U random /dev/sdb1    # Set UUID

# Remount
mount -o remount,rw /mnt/data
```

### RAID Configuration

```bash
# Software RAID with mdadm
# Create RAID array
mdadm --create /dev/md0 --level=5 --raid-devices=3 /dev/sdb1 /dev/sdc1 /dev/sdd1

# Create RAID 10
mdadm --create /dev/md0 --level=10 --raid-devices=4 /dev/sdb1 /dev/sdc1 /dev/sdd1 /dev/sde1

# Check RAID status
cat /proc/mdstat
mdadm --detail /dev/md0

# Stop/start array
mdadm --stop /dev/md0
mdadm --assemble --scan

# Monitor with mdadm.conf
echo 'DEVICE partitions' > /etc/mdadm.conf
mdadm --detail --scan >> /etc/mdadm.conf

# Add spare
mdadm /dev/md0 --add /dev/sde1

# Remove failed disk
mdadm /dev/md0 --fail /dev/sdb1
mdadm /dev/md0 --remove /dev/sdb1

# RAID levels:
# 0 - Striping (no redundancy)
# 1 - Mirroring
# 5 - Distributed parity
# 6 - Double parity
# 10 - Stripe of mirrors
```

---

## 3. Systemd and systemctl

### systemd Unit Files

systemd manages services, sockets, devices, mounts, and other units through unit files.

```ini
# /etc/systemd/system/myapp.service
[Unit]
Description=My Application
Documentation=https://example.com/docs
After=network.target postgresql.service
Requires=postgresql.service
Wants=redis.service

[Service]
Type=simple
User=appuser
Group=appgroup
WorkingDirectory=/opt/app
Environment=NODE_ENV=production
EnvironmentFile=/etc/app/env
ExecStartPre=/usr/bin/mkdir -p /var/run/app
ExecStart=/usr/bin/node /opt/app/server.js
ExecReload=/bin/kill -HUP $MAINPID
ExecStop=/bin/kill -TERM $MAINPID
Restart=always
RestartSec=10
TimeoutStartSec=30
TimeoutStopSec=60
StandardOutput=journal
StandardError=journal
SyslogIdentifier=myapp
PrivateTmp=yes
NoNewPrivileges=yes
ProtectSystem=strict
ReadWritePaths=/opt/app/data /var/log

[Install]
WantedBy=multi-user.target
```

```ini
# Socket unit /etc/systemd/system/myapp.socket
[Unit]
Description=My Application Socket

[Socket]
ListenStream=/run/myapp.sock
SocketMode=0660
SocketUser=appuser
SocketGroup=appgroup

[Install]
WantedBy=sockets.target
```

```ini
# Timer unit /etc/systemd/system/backup.timer
[Unit]
Description=Daily Backup

[Timer]
OnCalendar=daily
Persistent=true
RandomizedDelaySec=1h

[Install]
WantedBy=timers.target
```

### Managing Services

```bash
# Start, stop, restart
systemctl start nginx
systemctl stop nginx
systemctl restart nginx
systemctl reload nginx

# Enable/disable at boot
systemctl enable nginx
systemctl disable nginx

# Check status
systemctl status nginx
systemctl is-enabled nginx
systemctl is-active nginx

# View logs
journalctl -u nginx
journalctl -u nginx -f
journalctl -u nginx --since "1 hour ago"
journalctl -u nginx -p err
journalctl -u nginx --no-pager

# View dependency tree
systemctl list-dependencies nginx
systemctl list-dependencies --reverse nginx

# Mask/unmask (completely disable)
systemctl mask nginx
systemctl unmask nginx

# Edit service
systemctl edit nginx --full

# Daemon reload (after changing unit files)
systemctl daemon-reload

# Show all units
systemctl list-units --type=service
systemctl list-unit-files --state=enabled
```

### Targets and Boot

Targets are groups of units that the system can boot into.

```bash
# Common targets
# multi-user.target - Multi-user text mode
# graphical.target - Graphical mode
# rescue.target - Single user mode (rescue shell)
# emergency.target - Emergency shell
# reboot.target, poweroff.target, halt.target

# Change current target (switch without reboot)
systemctl isolate multi-user.target

# Set default target
systemctl set-default graphical.target
systemctl get-default

# List targets
systemctl list-units --type=target
systemctl list-unit-files --type=target

# Boot into different target temporarily
# At GRUB menu, press 'e' to edit
# Add to kernel line: systemd.unit=rescue.target
```

### Timers and Scheduled Tasks

Timers are systemd's replacement for cron with better dependency handling.

```ini
# /etc/systemd/system/cleanup.timer
[Unit]
Description=Daily Cleanup

[Timer]
OnCalendar=*-*-* 02:00:00
Persistent=true

[Install]
WantedBy=timers.target
```

```ini
# /etc/systemd/system/cleanup.service
[Unit]
Description=Cleanup Temp Files

[Service]
Type=oneshot
ExecStart=/usr/bin/find /tmp -type f -atime +7 -delete
PrivateTmp=true
```

```bash
# Manage timers
systemctl list-timers --all
systemctl start cleanup.timer
systemctl enable cleanup.timer

# One-time timers (using OnBootSec/OnActiveSec)
# OnBootSec=5min - 5 minutes after boot
# OnUnitActiveSec=1day - 1 day after last activation
```

### systemd Troubleshooting

```bash
# Boot analysis
systemd-analyze
systemd-analyze blame
systemd-analyze critical-chain nginx.service

# View failed units
systemctl --failed

# Boot-time troubleshooting
journalctl -b              # Current boot
journalctl -b -1          # Previous boot
journalctl --since "2024-01-01 00:00:00"

# Debug service failure
SYSTEMD_LOG_LEVEL=debug systemctl status nginx

# Reset failed state
systemctl reset-failed

# Kill all processes in cgroup
systemctl kill nginx

# Show unit dependencies
systemctl list-dependencies nginx

# Environment variables
systemctl show nginx | grep Environment
```

---

## 4. Log Management

### journald and journalctl

journald is systemd's logging service that provides structured logging with metadata.

```bash
# View all logs
journalctl

# Follow in real-time
journalctl -f

# Filter by unit
journalctl -u nginx
journalctl -u nginx.service

# Filter by time
journalctl --since "1 hour ago"
journalctl --since "2024-01-01 00:00:00" --until "2024-01-01 12:00:00"
journalctl -b -1          # Previous boot

# Filter by priority (0=emerg to 7=debug)
journalctl -p err
journalctl -p warning
journalctl -p 3

# Filter by process ID, user, group
journalctl _PID=1234
journalctl _UID=1000
journalctl _GID=1000

# Filter by executable path
journalctl /usr/bin/nginx

# Filter by hostname, machine ID
journalctl _HOSTNAME=server1
journalctl _MACHINE_ID=xxx

# Pretty output
journalctl -o short-iso
journalctl -o json
journalctl -o json-pretty

# Disk usage
journalctl --disk-usage
journalctl --vacuum-size=500M
journalctl --vacuum-time=7d

# Configuration
# /etc/systemd/journald.conf
[Journal]
Storage=persistent
Compress=yes
SystemMaxUse=500M
SystemKeepFree=1G
RuntimeMaxUse=100M
MaxFileSec=1month
ForwardToSyslog=yes
```

### Traditional Syslog

```bash
# Syslog facilities and priorities
# Facilities: kern, user, mail, daemon, auth, syslog, lpr, news, uucp, cron, local0-7
# Priorities: emerg, alert, crit, err, warning, notice, info, debug

# rsyslog configuration
# /etc/rsyslog.conf
# /etc/rsyslog.d/*.conf

# Log everything to file
*.* /var/log/all.log

# Log by facility
auth,authpriv.* /var/log/auth.log
cron.* /var/log/cron
mail.* /var/log/mail.log

# Log to remote server
*.* @logserver.example.com
*.* @@logserver.example.com:514

# Log to journal
*.* |/dev/journal

# Stop logging to console
*.* /dev/tty12

# Log rotation
# /etc/logrotate.d/nginx
/var/log/nginx/*.log {
    daily
    missingok
    rotate 14
    compress
    delaycompress
    notifempty
    create 0640 www-data adm
    sharedscripts
    postrotate
        systemctl reload nginx > /dev/null 2>&1 || true
    endscript
}
```

### logrotate Configuration

```bash
# /etc/logrotate.conf (global)
/var/log/wtmp {
    monthly
    create 0664 root utmp
    minsize 1M
    rotate 1
}

/var/log/btmp {
    missingok
    monthly
    create 0600 root utmp
    rotate 1
}

include /etc/logrotate.d

# Logrotate options
# daily/weekly/monthly - rotation frequency
# rotate N - keep N old logs
# compress - compress rotated logs
# delaycompress - delay compression
# missingok - don't error if file missing
# notifempty - don't rotate if empty
# create perms owner group - create new log with perms
# sharedscripts - run postrotate script once
# maxsize size - rotate when size exceeded
# minsize size - don't rotate smaller than this
# dateext - use date for extension

# Force rotation
logrotate -f /etc/logrotate.conf

# Debug mode
logrotate -d /etc/logrotate.conf
```

### Centralized Logging

```bash
# Rsyslog server receiving remote logs
# /etc/rsyslog.conf
# Enable UDP/TCP reception
module(load="imudp")
input(type="imudp" port="514")
module(load="imtcp")
input(type="imtcp" port="514")

# Store by source
template RemoteLogs,"/var/log/remote/%HOSTNAME%/%PROGRAMNAME%.log"
*.* ?RemoteLogs
```

---

## 5. Network Tools

### ip and ss Commands

```bash
# Show IP addresses
ip addr
ip addr show
ip -4 addr
ip -6 addr

# Add/delete IP address
ip addr add 192.168.1.100/24 dev eth0
ip addr del 192.168.1.100/24 dev eth0

# Show interfaces
ip link
ip link show
ip -s link

# Set interface up/down
ip link set eth0 up
ip link set eth0 down

# Change MAC address
ip link set eth0 address aa:bb:cc:dd:ee:ff

# Show routing table
ip route
ip route show
ip route get 8.8.8.8

# Add route
ip route add 192.168.2.0/24 via 192.168.1.1
ip route add default via 192.168.1.1

# Delete route
ip route del 192.168.2.0/24

# Show neighbors (ARP cache)
ip neigh
ip neigh show

# Add neighbor entry
ip neigh add 192.168.1.1 lladdr aa:bb:cc:dd:ee:ff dev eth0

# ss - Socket Statistics (replaces netstat)
ss -tuln           # TCP/UDP listening sockets
ss -tan             # All TCP connections
ss -tan state established
ss -tnp             # Show process
ss -ti              # Show timer info
ss -M               # Show marker

# Socket states: established, syn-sent, syn-recv, fin-wait-1, fin-wait-2, time-wait, closed, close-wait, last-ack, listening
```

### DNS Tools: dig, host, nslookup

```bash
# dig - DNS lookup
dig example.com
dig +short example.com
dig -t MX example.com
dig -x 8.8.8.8                    # Reverse DNS
dig @8.8.8.8 example.com         # Query specific server
dig +trace example.com            # Full trace
dig +additional example.com      # Show additional section

# Query specific record types
dig A example.com
dig AAAA example.com
dig NS example.com
dig CNAME www.example.com
dig TXT example.com
dig SOA example.com
dig ANY example.com

# host command
host example.com
host -t MX example.com
host -a example.com

# nslookup (interactive)
nslookup example.com
nslookup
> set type=MX
> example.com
> exit

# Reverse DNS
host 8.8.8.8
dig -x 8.8.8.8

# Check DNS propagation
dig +short NS example.com @8.8.8.8
dig +short NS example.com @8.8.4.4
```

### Network Testing: ping, traceroute, mtr

```bash
# ping
ping -c 4 8.8.8.8
ping -i 0.2 8.8.8.8         # Interval
ping -s 1000 8.8.8.8        # Packet size
ping -f 8.8.8.8             # Flood (root only)
ping -w 5 8.8.8.8           # Timeout

# ping6
ping6 -I eth0 fe80::1

# traceroute
traceroute 8.8.8.8
traceroute -I 8.8.8.8       # ICMP
traceroute -T 8.8.8.8       # TCP SYN
traceroute -U 8.8.8.8       # UDP

# traceroute with specific port
traceroute -T -p 443 8.8.8.8

# mtr (combines ping + traceroute)
mtr 8.8.8.8
mtr -c 10 8.8.8.8           # Count
mtr -r 8.8.8.8              # Report mode
mtr --report-wide 8.8.8.8

# Test bandwidth
# iperf3
# Server: iperf3 -s
# Client: iperf3 -c server -b 1G
```

### Port Scanning: nmap

```bash
# Basic scans
nmap 192.168.1.1                    # Default scan
nmap -p 80 192.168.1.1              # Specific port
nmap -p 1-1000 192.168.1.1          # Port range
nmap -p "1-1000,3389,8080" 192.168.1.1  # Multiple ranges

# Scan types
nmap -sS 192.168.1.1               # SYN scan (root)
nmap -sT 192.168.1.1               # TCP connect
nmap -sU 192.168.1.1               # UDP scan
nmap -sV 192.168.1.1               # Version detection
nmap -O 192.168.1.1                # OS detection

# Service detection
nmap -sV --version-intensity 5 192.168.1.1

# Scripts (NSE)
nmap --script default 192.168.1.1
nmap --script vuln 192.168.1.1
nmap --script http-headers 192.168.1.1
nmap --script ssl-enum-ciphers -p 443 192.168.1.1

# Output
nmap -oA output 192.168.1.1        # All formats
nmap -oN output.nmap 192.168.1.1   # Normal
nmap -oX output.xml 192.168.1.1   # XML

# Timing and performance
nmap -T4 192.168.1.1               # Aggressive (0-5)
nmap --max-retries 3 192.168.1.1

# Scan entire subnet
nmap 192.168.1.0/24
nmap -sn 192.168.1.0/24            # Ping scan only
```

### tcpdump and Wireshark

```bash
# Basic capture
tcpdump -i eth0
tcpdump -i any                      # All interfaces

# Filter by host
tcpdump host 192.168.1.1
tcpdump src 192.168.1.1
tcpdump dst 192.168.1.1

# Filter by port
tcpdump port 80
tcpdump src port 443
tcpdump portrange 1-1000

# Filter by protocol
tcpdump icmp
tcpdump tcp
tcpdump udp

# Filter expressions
tcpdump 'port 80 and host 192.168.1.1'
tcpdump 'tcp[tcpflags] & (tcp-syn|tcp-ack) != 0'
tcpdump 'port 80 and tcp[((tcp[12:1] & 0xf0) >> 2):4] = 0x47455420'  # HTTP GET

# Output options
tcpdump -w capture.pcap             # Save to file
tcpdump -r capture.pcap            # Read from file
tcpdump -nn                        # Don't resolve names
tcpdump -v                         # Verbose
tcpdump -vv                        # More verbose
tcpdump -X                         # Hex and ASCII
tcpdump -A                         # ASCII only

# Capture specific number of packets
tcpdump -c 100 -w capture.pcap

# Ring buffer
tcpdump -W 5 -C 100 -w capture.pcap

# Wireshark CLI
tshark -i eth0 -f "port 80" -w capture.pcap
tshark -r capture.pcap -Y "http.request.method == GET"
```

---

## 6. Process Management

### Process Lifecycle and States

In Linux, a process is an instance of a running program. Understanding the process lifecycle and its various states is fundamental to system administration, debugging, and performance tuning.

#### Process Creation

Processes are created primarily through two system calls: `fork()` and `exec()`. When a process calls `fork()`, the kernel creates a copy of the parent process, creating a child process with its own process ID (PID). The child process then typically calls `exec()` to replace its memory space with a new program.

```c
// Simplified view of fork() behavior
pid_t pid = fork();

if (pid == 0) {
    // Child process
    execve("/path/to/program", argv, envp);
} else if (pid > 0) {
    // Parent process
    waitpid(pid, &status, 0);
} else {
    // Error
    perror("fork failed");
}
```

The kernel maintains a task structure (struct task_struct) for each process, containing:
- Process ID and parent PID
- State (running, sleeping, etc.)
- Priority and scheduling information
- File descriptors
- Memory mapping
- Credentials (UID, GID)
- Signal handlers

#### Process States

Linux defines several process states, visible in the `ps` output under the `STAT` column:

| State | Description |
|-------|-------------|
| **R** (Running or Runnable) | Either currently executing on CPU or waiting in the run queue |
| **S** (Interruptible Sleep) | Sleeping, waiting for an event (can be interrupted by signals) |
| **D** (Uninterruptible Sleep) | Usually waiting for I/O, cannot be interrupted |
| **T** (Stopped) | Process has been stopped, typically by a signal |
| **Z** (Zombie) | Process has terminated but parent hasn't reaped it |
| **X** (Dead) | Process is dead and being reaped (rarely visible) |

```bash
# View process states
ps aux

# View process tree with states
ps auxf

# Real-time process state monitoring
watch -n 1 'ps -eo pid,ppid,state,cmd --sort=+state'
```

#### The Zombie Problem

When a child process terminates, it enters the zombie state (Z). The kernel retains the process's exit status and resource usage statistics until the parent calls `wait()` or `waitpid()`. If the parent fails to reap its children, zombie processes accumulate, eventually exhausting the system's PID limit.

```python
#!/usr/bin/env python3
"""
Example of proper process reaping in Python
"""
import os
import sys
import signal
import time

def sigchld_handler(signum, frame):
    """Handle child termination"""
    while True:
        try:
            pid, status = os.waitpid(-1, os.WNOHANG)
            if pid == 0:
                break
            exit_code = os.WEXITSTATUS(status)
            print(f"Child {pid} exited with code {exit_code}")
        except ChildProcessError:
            break
        except OSError:
            break

# Register signal handler
signal.signal(signal.SIGCHLD, sigchld_handler)

# Fork a child
pid = os.fork()
if pid == 0:
    # Child process
    print(f"Child {os.getpid()} sleeping...")
    time.sleep(1)
    print(f"Child {os.getpid()} exiting")
    sys.exit(42)
else:
    # Parent process
    print(f"Parent {os.getpid()}, child is {pid}")
    time.sleep(2)
    print("Parent done")
```

### Process Inspection Tools

Linux provides numerous tools for inspecting and debugging processes. Understanding these tools deeply enables effective system troubleshooting.

#### ps Command

The `ps` command displays information about running processes. Its output can be customized extensively.

```bash
# Basic process listing
ps

# Full format listing
ps aux

# Forest view (shows parent-child relationships)
ps auxf

# Threads view
ps -eLf

# Custom columns
ps -eo pid,ppid,uid,gid,ni,pri,pcpu,pmem,vsz,rss,stat,comm

# Sort by memory usage
ps aux --sort=-pmem | head

# Filter by process name
ps aux | grep nginx

# View process of a specific user
ps -U username -u username
```

Key `ps` columns:
- **PID**: Process ID
- **PPID**: Parent Process ID
- **UID**: User ID of process owner
- **PRI**: Priority (lower = higher priority)
- **NI**: Nice value (-20 to 19)
- **VSZ**: Virtual memory size (KB)
- **RSS**: Resident Set Size (actual physical memory)
- **STAT**: Process state
- **TIME**: Cumulative CPU time
- **COMMAND**: Command name

#### top and htop

```bash
# top basics
top

# Batch mode (useful for scripting)
top -b -n 1

# Top by memory
top -o MEM

# Top by CPU
top -o %CPU

# htop (more interactive)
htop

# htop with specific columns
htop -d 10 -C

# atop (advanced system monitor)
atop
```

In `htop`, you can:
- Press `F` to select a sort field
- Press `t` to show tree view
- Press `/` to filter processes
- Press `u` to filter by user
- Press `k` to send signals to processes

#### lsof - List Open Files

```bash
# All open files
lsof

# Files for specific process
lsof -p 1234

# Files for specific user
lsof -u username

# Network connections
lsof -i

# TCP connections only
lsof -i TCP

# Listening ports
lsof -i -sTCP:LISTEN

# Files on specific port
lsof -i :80

# Files deleted but still open
lsof +L1
```

### Process Groups, Sessions, and Daemonization

Understanding process groups and sessions is crucial for understanding how processes relate to each other and how daemons work.

#### Process Groups

A process group is a collection of one or more processes. Each process group has a Process Group ID (PGID), which is typically the PID of the process group leader.

```c
#include <unistd.h>
#include <stdio.h>
#include <sys/types.h>

int main() {
    pid_t pid = getpid();
    pid_t pgid = getpgrp();
    pid_t sid = getsid(0);
    
    printf("PID: %d\n", pid);
    printf("PGID: %d\n", pgid);
    printf("SID: %d\n", sid);
    
    return 0;
}
```

#### Sessions

A session is a collection of process groups. Sessions are used to associate a terminal with a group of processes. When a user logs in, a new session is created with the login shell as the session leader.

```
Session
├── Session Leader (login shell)
│   ├── Process Group 1
│   │   ├── Process A
│   │   └── Process B
│   └── Process Group 2
│       └── Process C
```

#### Daemonization

A daemon is a background process that runs independently of any terminal. The proper way to daemonize a process involves several steps:

```c
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

void daemonize(const char *program) {
    /* Step 1: Fork and exit parent */
    pid_t pid = fork();
    if (pid < 0) {
        perror("fork failed");
        exit(1);
    }
    if (pid > 0) {
        /* Parent exits */
        exit(0);
    }
    
    /* Step 2: Create new session */
    if (setsid() < 0) {
        perror("setsid failed");
        exit(1);
    }
    
    /* Step 3: Fork again to prevent acquiring a controlling terminal */
    pid = fork();
    if (pid < 0) {
        perror("second fork failed");
        exit(1);
    }
    if (pid > 0) {
        exit(0);
    }
    
    /* Step 4: Change working directory */
    chdir("/");
    
    /* Step 5: Close standard file descriptors */
    close(STDIN_FILENO);
    close(STDOUT_FILENO);
    close(STDERR_FILENO);
    
    /* Step 6: Redirect to /dev/null */
    open("/dev/null", O_RDONLY);  // stdin
    open("/dev/null", O_WRONLY);  // stdout
    open("/dev/null", O_WRONLY);  // stderr
}

int main() {
    daemonize("mydaemon");
    
    /* Daemon logic here */
    while (1) {
        sleep(10);
    }
    
    return 0;
}
```

The six steps of daemonization:
1. **Fork** - Parent exits, child continues
2. **setsid()** - Create new session, become session leader
3. **Fork again** - Prevent future acquisition of a controlling terminal
4. **chdir("/")** - Prevent blocking on mounted filesystems
5. **Close file descriptors** - Release stdin, stdout, stderr
6. **Redirect to /dev/null** - Prevent I/O to terminals

### Signals and Signal Handling

Signals are software interrupts sent to processes. They are used for process communication, termination, and error handling.

#### Common Signals

| Signal | Number | Default Action | Description |
|--------|--------|----------------|-------------|
| SIGHUP | 1 | Terminate | Hangup (terminal closed) |
| SIGINT | 2 | Terminate | Interrupt (Ctrl+C) |
| SIGQUIT | 3 | Core dump | Quit (Ctrl+\) |
| SIGKILL | 9 | Terminate | Kill (cannot be caught) |
| SIGSEGV | 11 | Core dump | Segmentation fault |
| SIGTERM | 15 | Terminate | Termination request (graceful) |
| SIGSTOP | 19 | Stop | Stop process (cannot be caught) |
| SIGTSTP | 20 | Stop | Terminal stop (Ctrl+Z) |
| SIGCONT | 18 | Continue | Continue if stopped |

```bash
# Send signals
kill -TERM 1234
kill -KILL 1234

# Send to process group
kill -TERM -1234

# Send to all processes matching name
pkill -TERM nginx

# Send custom signal
kill -USR1 1234
```

#### Signal Handling in C

```c
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>

volatile sig_atomic_t running = 1;

void sigint_handler(int sig) {
    running = 0;
}

void setup_signal_handlers() {
    struct sigaction sa;
    sa.sa_handler = sigint_handler;
    sigemptyset(&sa.sa_mask);
    sa.sa_flags = 0;  // SA_RESTART to auto-restart interrupted syscalls
    
    sigaction(SIGINT, &sa, NULL);
    sigaction(SIGTERM, &sa, NULL);
}

int main() {
    setup_signal_handlers();
    
    while (running) {
        /* Main loop */
    }
    
    printf("Shutting down gracefully...\n");
    return 0;
}
```

#### Signal Handling in Python

```python
import signal
import sys

running = True

def signal_handler(signum, frame):
    global running
    print(f"Received signal {signum}")
    running = False

# Register handlers
signal.signal(signal.SIGINT, signal_handler)
signal.signal(signal.SIGTERM, signal_handler)

# Custom signal handling
def usr1_handler(signum, frame):
    print("USR1 received - reloading config")
    # Reload configuration

signal.signal(signal.SIGUSR1, usr1_handler)

while running:
    pass
```

### Process Debugging with strace and gdb

#### strace - System Call Tracer

`strace` intercepts and records system calls made by a process and signals received by it.

```bash
# Trace new process
strace -f ./program

# Trace with timestamps
strace -t -f ./program

# Trace with timing
strace -r -f ./program

# Filter specific system calls
strace -e trace=write,read -f ./program

# Trace network calls
strace -e trace=network -f ./program

# Trace file operations
strace -e trace=file -f ./program

# Save to file
strace -o output.txt -f ./program

# Attach to running process
strace -p 1234

# Summary of system call usage
strace -c -f ./program
```

Common `strace` options:
- `-f` - Follow forks
- `-t` - Timestamps
- `-r` - Relative timestamps
- `-e trace=set` - Filter syscalls
- `-o file` - Output to file
- `-p pid` - Attach to process
- `-c` - Summary count

#### gdb - GNU Debugger

```bash
# Debug program
gdb ./program

# Debug with arguments
gdb --args ./program arg1 arg2

# Attach to running process
gdb ./program -p 1234

# Core dump analysis
gdb ./program core
```

Useful gdb commands:
```
(gdb) break main           # Set breakpoint
(gdb) run                 # Start program
(gdb) continue            # Continue execution
(gdb) next                # Next line (step over)
(gdb) step                # Next line (step into)
(gdb) print var           # Print variable
(gdb) backtrace           # Show call stack
(gdb) info registers      # Show registers
(gdb) disassemble         # Show assembly
(gdb) watch var           # Watch variable
(gdb) condition 1 var==5 # Conditional breakpoint
```

#### Example: Debugging a Hang

```bash
# Find what's blocking a process
strace -p 1234

# Check system calls being made
strace -p 1234 -e trace=read,write

# Use gdb to see where it's stuck
gdb -p 1234
(gdb) bt  # backtrace
(gdb) info threads
(gdb) thread apply all bt
```

## 7. Memory Management

### Virtual Memory and Paging

Linux uses virtual memory to provide each process with its own address space. This isolation provides security and allows memory overcommit.

#### Virtual Memory Layout

```
+------------------+ 0xFFFFFFFF (4GB)
|      Kernel     |  (0xC0000000 - 0xFFFFFFFF)
+------------------+ 
|                  |
|      User        |
|     Address      |
|     Space        |
|                  |
+------------------+ 0x00000000
```

On 64-bit systems, the address space is much larger:
- User space: 128 TB (typically)
- Kernel space: 128 TB (typically)

#### Page Tables

Linux uses a multi-level page table structure for efficiency:

```c
// Simplified page table entry structure
struct page {
    unsigned long flags;
    atomic_t _count;
    atomic_t _mapcount;
    unsigned long private;
    struct address_space *mapping;
    pgoff_t index;
    struct list_head lru;
};
```

The page table levels on x86_64:
1. PGD (Page Global Directory) - 9 bits
2. PUD (Page Upper Directory) - 9 bits
3. PMD (Page Middle Directory) - 9 bits
4. PTE (Page Table Entry) - 9 bits
5. Offset - 12 bits (4KB pages)

This gives: 9+9+9+9+12 = 39 bits = 512GB per PGD entry, but limited to 128TB in practice.

#### Memory Mapping

```bash
# View process memory map
pmap -x 1234

# Detailed memory information
cat /proc/1234/maps

# Memory regions with permissions
# Address           Perms Offset  Device   Inode      Path
# 00400000-00452000 r-xp 00000000 fd:00  12345678   /bin/bash
```

### Memory Monitoring Tools

#### /proc/meminfo

```bash
cat /proc/meminfo
```

Key fields:
- **MemTotal**: Total usable RAM
- **MemFree**: Unused memory
- **MemAvailable**: Memory available for allocation (estimate)
- **Buffers**: Memory for block device buffers
- **Cached**: Page cache memory
- **SwapCached**: Swap in memory
- **SwapTotal**: Total swap space
- **SwapFree**: Free swap space
- **Dirty**: Memory waiting to be written to disk
- **Writeback**: Memory being actively written
- **AnonPages**: Anonymous memory (heap, stack)
- **Shmem**: Shared memory

#### vmstat

```bash
# vmstat with interval
vmstat 1

# Extended output
vmstat -s

# Disk statistics
vmstat -d

# Slabinfo
vmstat -m
```

Key columns:
- **si/so**: Swap in/out
- **bi/bo**: Blocks in/out
- **in/cs**: Interrupts/context switches
- **us/sy/id/wa**: CPU user/system/idle/wait

#### sar (System Activity Reporter)

```bash
# Memory usage over time
sar -r 1

# Swap activity
sar -S 1

# Overall memory stats
sar -r

# Historical data
sar -r -f /var/log/sa/sa01
```

### The OOM Killer

When Linux runs out of memory, the Out-of-Memory (OOM) killer selects and terminates processes to free memory.

#### OOM Score Calculation

The kernel calculates an oom_score for each process:

```
oom_score = (process_memory / total_memory) * 1000 + oom_adj
```

- `oom_adj` can be adjusted via `/proc/PID/oom_score_adj` (-1000 to 1000)
- -1000: Never kill
- 1000: Very likely to kill

```bash
# View OOM score
cat /proc/1234/oom_score

# View OOM score adjustment
cat /proc/1234/oom_score_adj

# Adjust OOM score (make less likely to be killed)
echo -500 > /proc/1234/oom_score_adj

# Check if OOM killer has been invoked
dmesg | grep -i "out of memory"
dmesg | grep -i "killed process"
```

#### Configuring OOM Behavior

```bash
# Disable OOM killer for a process (not recommended)
echo -1000 > /proc/PID/oom_score_adj

# Check vm.overcommit_memory
# 0: Heuristic (default)
# 1: Always overcommit
# 2: Never overcommit (strict)

# View current setting
cat /proc/sys/vm/overcommit_memory

# Set to never overcommit
sysctl vm.overcommit_memory=2
```

### Huge Pages and Memory Cgroups

#### Transparent Huge Pages (THP)

```bash
# Check THP status
cat /sys/kernel/mm/transparent_hugepage/enabled
cat /sys/kernel/mm/transparent_hugepage/defrag

# Disable THP (recommended for databases)
echo never > /sys/kernel/mm/transparent_hugepage/enabled
echo never > /sys/kernel/mm/transparent_hugepage/defrag
```

#### Explicit Huge Pages

```bash
# Allocate huge pages
echo 10 > /proc/sys/vm/nr_hugepages

# Check huge page size
getconf PAGESIZE

# Use huge pages in application
#include <sys/mman.h>
void *ptr = mmap(NULL, size, PROT_READ|PROT_WRITE, 
                 MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
madvisep(ptr, MADV_HUGEPAGE);
```

#### Memory Cgroups

```bash
# Create memory cgroup
mkdir -p /sys/fs/cgroup/memory/mygroup

# Set memory limit
echo 1G > /sys/fs/cgroup/memory/mygroup/memory.limit_in_bytes

# Add process to cgroup
echo PID > /sys/fs/cgroup/memory/mygroup/cgroup.procs

# Set memory + swap limit
echo 1G > /sys/fs/cgroup/memory/mygroup/memory.memsw.limit_in_bytes
```

### Swap Configuration

#### Monitoring Swap Usage

```bash
# Swappiness
cat /proc/sys/vm/swappiness

# Current swap usage
swapon -s

# Detailed swap info
cat /proc/swaps

# Swap usage per process
for pid in $(ls /proc | grep -E '^[0-9]+$'); do 
    if [ -f /proc/$pid/smaps ]; then
        swap=$(grep Swap /proc/$pid/smaps | awk '{sum+=$2} END {print sum}')
        if [ $swap -gt 0 ]; then
            name=$(ps -p $pid -o comm=)
            echo "$pid $name $swap"
        fi
    fi
done | sort -k3 -rn | head
```

#### Tuning Swap

```bash
# Reduce swappiness (for databases, etc.)
sysctl vm.swappiness=10

# Make permanent
echo "vm.swappiness=10" >> /etc/sysctl.conf

# Create swap file
dd if=/dev/zero of=/swapfile bs=1M count=2048
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile

# Add to fstab
echo "/swapfile none swap sw 0 0" >> /etc/fstab
```

## 8. Filesystem

### VFS Layer

The Virtual File System (VFS) is a kernel abstraction layer that allows different filesystem types to coexist. It provides a common interface for file operations.

#### VFS Data Structures

```c
// Simplified VFS structures
struct super_block {
    struct super_operations *s_op;
    struct dentry *s_root;
    struct list_head s_inodes;
    void *s_fs_info;
    // ...
};

struct inode {
    umode_t i_mode;
    uid_t i_uid;
    gid_t i_gid;
    loff_t i_size;
    struct super_block *i_sb;
    struct inode_operations *i_op;
    struct file_operations *i_fop;
    // ...
};

struct file {
    struct path f_path;
    struct inode *f_inode;
    struct file_operations *f_op;
    loff_t f_pos;
    // ...
};
```

#### System Calls

```c
// File operations map to VFS calls
open("/path/file", O_RDONLY);
// -> sys_open()
// -> do_sys_open()
// -> do_filp_open()
// -> path_openat()
// -> link_path_walk()
// -> step into filesystem-specific code
```

### Inodes, Links, and File Attributes

#### Inodes

Every file has an inode containing metadata:
- File type and permissions
- Owner (UID/GID)
- File size
- Timestamps (atime, mtime, ctime)
- Link count
- Pointers to data blocks

```bash
# View inode
ls -li file

# Find files by inode
find . -inum 12345

# View inode details
stat file

# Extended attributes
lsattr file
chattr +a file  # append only
chattr +i file  # immutable
```

#### Hard Links

```bash
# Create hard link
ln file hardlink

# Hard links share the same inode
# Cannot cross filesystems
# Cannot link to directories

# View link count
ls -l file  # shows link count
stat file   # shows "Links:"
```

#### Symbolic Links

```bash
# Create symbolic link
ln -s file symlink

# Symlinks are separate files pointing to path
# Can cross filesystems
# Can link to directories

# View symlink target
readlink symlink

# Find broken symlinks
find . -type l -! -exec test -e {} \; -print
```

### Filesystem Types: ext4, xfs, btrfs

#### ext4 (Fourth Extended Filesystem)

```bash
# Create ext4 filesystem
mkfs.ext4 /dev/sdb1

# Tunable parameters
mkfs.ext4 -E stride=128,stripe-width=128 /dev/sdb1

# Check filesystem
e2fsck /dev/sdb1

# Resize
resize2fs /dev/sdb1

# Features: extents, delayed allocation, journal checksum
```

ext4 characteristics:
- Max file size: 16TB
- Max filesystem size: 1EB
- Journaling for consistency
- Extents for large files (replaces block mapping)
- Delayed allocation (better performance)

#### XFS

```bash
# Create XFS filesystem
mkfs.xfs /dev/sdb1

# XFS quota
xfs_quota -x -c 'limit bsoft=10g bhard=12g user1' /mount

# Defragment
xfs_fsr /dev/sdb1

# Check
xfs_check /dev/sdb1
xfs_repair /dev/sdb1
```

XFS characteristics:
- Designed for large filesystems (up to 1EB)
- Excellent scalability
- B+trees for metadata
- Journaling only (metadata)
- Copy-on-write snapshots (with LVM)

#### BTRFS (B-tree Filesystem)

```bash
# Create BTRFS
mkfs.btrfs /dev/sdb1

# Create RAID
mkfs.btrfs -d raid1 -m raid1 /dev/sdb1 /dev/sdb2

# Snapshot
btrfs subvolume snapshot /mnt /mnt/snapshot

# Send/receive
btrfs send /mnt/snapshot | btrfs receive /backup

# Balance
btrfs balance start -dconvert=raid1 -mconvert=raid1 /mnt
```

BTRFS characteristics:
- Copy-on-write
- Snapshots and clones
- Built-in RAID (0, 1, 10)
- Subvolumes
- Compression (zstd, lzo)
- Checksumming
- Not yet production-stable for some use cases

### IO Scheduling

#### IO Schedulers

```bash
# Check current scheduler
cat /sys/block/sda/queue/scheduler

# Available schedulers
# none (no scheduling)
# mq-deadline
# bfq (budget fair queuing)
# kyber

# Change scheduler
echo mq-deadline > /sys/block/sda/queue/scheduler

# Make permanent
echo "options sda scheduler=mq-deadline" >> /etc/modprobe.d/scheduler.conf
```

#### Scheduler Comparison

| Scheduler | Best For |
|-----------|----------|
| **none** | SSD, database workloads |
| **mq-deadline** | General purpose, mixed workloads |
| **bfq** | Interactive tasks, desktop |
| **kyber** | Fast storage (NVMe) |

#### Tuning IO

```bash
# Read ahead
blockdev --getra /dev/sda
blockdev --setra 4096 /dev/sda

# Queue depth
cat /sys/block/sda/queue/nr_requests

# I/O priority
ionice -c 2 -n 0 -p 1234
# -c class: 0=none, 1=real-time, 2=best-effort, 3=idle
# -n level: 0-7 (lower = higher priority)
```

### Virtual Filesystems: /proc and /sys

#### /proc Filesystem

```bash
# Process information
/proc/PID/cmdline      # Command line
/proc/PID/cwd          # Current working directory
/proc/PID/environ      # Environment variables
/proc/PID/exe          # Executable
/proc/PID/fd/          # Open file descriptors
/proc/PID/maps         # Memory maps
/proc/PID/smaps        # Detailed memory maps
/proc/PID/stack        # Stack trace
/proc/PID/status       # Status info
/proc/PID/task/       # Threads

# System information
/proc/cpuinfo          # CPU info
/proc/meminfo          # Memory info
/proc/interrupts      # Interrupt counts
/proc/loadavg         # Load average
/proc/uptime          # System uptime
/proc/version          # Kernel version
/proc/cmdline         # Kernel command line
/proc/sys/            # Tunable parameters
```

#### /sys Filesystem

```bash
# Block devices
/sys/block/
/sys/block/sda/queue/

# CPU
/sys/devices/system/cpu/

# Devices
/sys/dev/

# Kernel objects
/sys/kernel/

# Module parameters
/sys/module/
```

## 9. Networking

### Network Namespaces

Network namespaces provide isolated network stacks. Each namespace has its own:
- Network interfaces
- Routing tables
- iptables rules
- Port numbers

```bash
# Create network namespace
ip netns add myns

# List namespaces
ip netns list

# Execute command in namespace
ip netns exec myns ip addr
ip netns exec myns ping 8.8.8.8

# Add interface to namespace
ip link add veth0 type veth peer name veth1
ip link set veth1 netns myns

# Delete namespace
ip netns del myns
```

#### Example: Container Networking

```bash
# Create namespace for container
ip netns add container1

# Create veth pair
ip link add veth-host type veth peer name veth-container

# Move container side to namespace
ip link set veth-container netns container1

# Configure host side (bridge)
ip addr add 10.0.0.1/24 dev veth-host
ip link set veth-host up

# Configure container side
ip netns exec container1 ip addr add 10.0.0.2/24 dev veth-container
ip netns exec container1 ip link set veth-container up
ip netns exec container1 ip link set lo up
ip netns exec container1 ip route add default via 10.0.0.1
```

### iptables and nftables

#### iptables Tables and Chains

```
raw        → mangle → nat (PREROUTING)
              ↓
           filter (FORWARD)
              ↓
           nat (POSTROUTING)
              ↓
           mangle → nat (OUTPUT)
              ↓
           filter (OUTPUT)
```

#### Basic iptables Commands

```bash
# List rules
iptables -L -n -v
iptables -t nat -L -n -v

# Allow SSH (with rate limiting)
iptables -A INPUT -p tcp --dport 22 -m state --state NEW \
    -m recent --set
iptables -A INPUT -p tcp --dport 22 -m state --state NEW \
    -m recent --update --seconds 60 --hitcount 4 -j DROP
iptables -A INPUT -p tcp --dport 22 -j ACCEPT

# Allow established connections
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# NAT (MASQUERADE)
iptables -t nat -A POSTROUTING -s 10.0.0.0/24 ! -o lo -j MASQUERADE

# Port forwarding
iptables -t nat -A PREROUTING -p tcp --dport 8080 -j REDIRECT --to-port 80

# Drop everything else
iptables -A INPUT -j DROP
```

#### nftables

```bash
# List rules
nft list ruleset
nft list table ip filter
nft list chain ip filter INPUT

# Create table and chain
nft add table ip filter
nft add chain ip filter INPUT { type filter hook input priority 0; policy accept; }

# Add rules
nft add rule ip filter INPUT ct state established,related accept
nft add rule ip filter INPUT tcp dport 22 accept
nft add rule ip filter INPUT counter drop

# NAT
nft add table ip nat
nft add chain ip nat POSTROUTING { type nat hook postrouting priority 100; }
nft add rule ip nat POSTROUTING oifname "eth0" counter masquerade
```

### eBPF and bpftrace

Extended Berkeley Packet Filter (eBPF) allows running sandboxed programs in the kernel without modifying kernel source.

#### bpftrace

```bash
# List available probes
bpftrace -l

# Trace open syscalls
bpftrace -e 'BEGIN { printf("Tracing... Hit Ctrl-C to end.\n"); } 
            tracepoint:syscalls:sys_enter_open { printf("%s %s\n", comm, str(args->filename)); }'

# Measure block I/O latency
bpftrace -e 'kprobe:blk_account_io_start { @start[comm] = nsecs; }
             kprobe:blk_account_io_done /@start[comm]/ { 
                @latency = hist(nsecs - @start[comm]); 
                delete(@start[comm]); 
             }'

# Network connection tracking
bpftrace -e 'tracepoint:net:netif_receive_skb { 
                @bytes[comm] = sum(args->len); 
             }'
```

### TCP/IP Stack Internals

#### TCP State Machine

```
CLOSED → LISTEN ← SYN → SYN-SENT → ESTABLISHED ←→ ESTABLISHED
  ↑                              ↓
  └──────── FIN-WAIT-1 ← FIN ←← CLOSE-WAIT
                    ↓
               FIN-WAIT-2 ←← LAST-ACK
                    ↓
                 CLOSING ←← ACK
                    ↓
                  TIME-WAIT
                    ↓
                  CLOSED
```

#### TCP Handshake

```bash
# View TCP connection states
ss -tan

# Detailed TCP info
ss -tan state time-wait

# TCP memory info
cat /proc/net/sockstat
```

#### Congestion Control Algorithms

```bash
# List available algorithms
sysctl net.ipv4.tcp_available_congestion_control

# Current algorithm
sysctl net.ipv4.tcp_congestion_control

# Set algorithm
sysctl net.ipv4.tcp_congestion_control=bbr

# TCP tuning
sysctl net.ipv4.tcp_window_scaling=1
sysctl net.ipv4.tcp_timestamps=1
sysctl net.ipv4.tcp_sack=1
```

### Network Tuning with sysctl

```bash
# Network core
sysctl -w net.core.rmem_max=16777216
sysctl -w net.core.wmem_max=16777216
sysctl -w net.core.rmem_default=8388608
sysctl -w net.core.wmem_default=8388608
sysctl -w net.core.netdev_max_backlog=5000
sysctl -w net.core.somaxconn=1024

# TCP
sysctl -w net.ipv4.tcp_rmem="4096 87380 16777216"
sysctl -w net.ipv4.tcp_wmem="4096 65536 16777216"
sysctl -w net.ipv4.tcp_congestion_control=bbr
sysctl -w net.ipv4.tcp_fastopen=3

# Keepalive
sysctl -w net.ipv4.tcp_keepalive_time=600
sysctl -w net.ipv4.tcp_keepalive_intvl=60
sysctl -w net.ipv4.tcp_keepalive_probes=3

# Routing
sysctl -w net.ipv4.conf.all.forwarding=1
sysctl -w net.ipv4.conf.default.forwarding=1

# Make permanent
# Add to /etc/sysctl.conf or /etc/sysctl.d/99-custom.conf
```

## 10. Boot and Init Systems

### Boot Process

#### Boot Stages

1. **BIOS/UEFI**: Hardware initialization, find boot device
2. **Bootloader**: Load kernel (GRUB2, systemd-boot)
3. **Kernel**: Initialize hardware, start init
4. **Init**: Start userspace services

```bash
# View boot messages
dmesg | less

# Journal boot
journalctl -b

# Boot time analysis
systemd-analyze
systemd-analyze blame
systemd-analyze critical-chain
```

#### Boot Loaders

**GRUB2:**
```bash
# Edit GRUB config
vim /etc/default/grub

# Regenerate config
update-grub  # Debian/Ubuntu
grub2-mkconfig -o /boot/grub2/grub.cfg  # RHEL

# GRUB menu during boot: e to edit, c for command line
```

**systemd-boot:**
```bash
# List entries
bootctl list

# Set default entry
bootctl set-default entry-name
```

### systemd Deep Dive

#### Unit Types

| Type | Description | Extension |
|------|-------------|-----------|
| service | Daemon process | .service |
| socket | IPC socket | .socket |
| device | Device node | .device |
| mount | Filesystem mount | .mount |
| automount | Auto-mount | .automount |
| swap | Swap file | .swap |
| target | Group of units | .target |
| path | Path monitoring | .path |
| timer | Scheduled task | .timer |
| slice | Resource group | .slice |
| scope | External process | .scope |

#### Service Unit Example

```ini
[Unit]
Description=My Application
Documentation=https://example.com/docs
After=network.target postgresql.service
Requires=postgresql.service
Wants=redis.service

[Service]
Type=notify
User=appuser
Group=appgroup
WorkingDirectory=/opt/app
Environment=NODE_ENV=production
EnvironmentFile=/etc/app/env
ExecStartPre=/usr/bin/mkdir -p /var/run/app
ExecStart=/usr/bin/node /opt/app/server.js
ExecReload=/bin/kill -HUP $MAINPID
ExecStop=/bin/kill -TERM $MAINPID
Restart=always
RestartSec=10
TimeoutStartSec=30
TimeoutStopSec=60
StandardOutput=journal
StandardError=journal
SyslogIdentifier=myapp

# Resource limits
MemoryMax=1G
CPUQuota=50%
LimitNOFILE=65536

[Install]
WantedBy=multi-user.target
```

#### Managing Services

```bash
# Start/stop/restart
systemctl start nginx
systemctl stop nginx
systemctl restart nginx
systemctl reload nginx

# Enable/disable (boot)
systemctl enable nginx
systemctl disable nginx

# Status
systemctl status nginx
systemctl is-enabled nginx
systemctl is-active nginx

# View logs
journalctl -u nginx
journalctl -u nginx -f
journalctl -u nginx --since "1 hour ago"
journalctl -u nginx -p err

# Dependencies
systemctl list-dependencies nginx
systemctl list-dependencies --reverse nginx
```

#### Targets

```bash
# Common targets
multi-user.target      # Multi-user text mode
graphical.target       # Graphical mode
rescue.target          # Single user mode
emergency.target      # Emergency shell
shutdown.target       # Shutdown

# Change target
systemctl isolate multi-user.target
systemctl set-default graphical.target
```

### cgroups v2 and Resource Control

#### cgroups v2 Hierarchy

```
cgroup root (unified)
├── system.slice/
│   ├── nginx.service/
│   └── postgresql.service/
├── user.slice/
│   └── user-1000.slice/
└── machine.slice/
```

#### Resource Controllers

```bash
# Available controllers
ls /sys/fs/cgroup/

# CPU controller
# cpu.max, cpu.weight, cpu.weight.nice
# Example: cpu.max="100000 100000" (100%)

# Memory controller  
# memory.max, memory.high, memory.low
# Example: memory.max=1G

# IO controller
# io.max, io.weight
# Example: io.max="8:0 wbps=104857600"

# PID controller
# pids.max
# Example: pids.max=100
```

#### systemd Slice Example

```ini
[Unit]
Description=Limited Application Slice
DefaultDependencies=no
Before=slices.target

[Slice]
MemoryMax=2G
CPUWeight=100
IOWeight=100
TasksMax=50
```

### Container Runtimes

#### containerd

```bash
# containerd is the industry-standard container runtime
# Used by Docker, Kubernetes

# containerd CLI
ctr images list
ctr images pull docker.io/library/nginx:latest
ctr run -d docker.io/library/nginx:latest nginx

# Container management
ctr container list
ctr container info CONTAINER_ID
ctr task start CONTAINER_ID
ctr task pause CONTAINER_ID
ctr task resume CONTAINER_ID
```

#### CRI-O

```bash
# CRI-O - Kubernetes container runtime
# Designed for Kubernetes

# Manage images
crictl images
crictl pull nginx:latest

# Manage containers
crictl ps
crictl logs CONTAINER_ID
```

## 11. Shell and Scripting

### Bash Internals

#### Bash Execution Flow

```bash
# When you run ./script.sh:
# 1. Check shebang (#!/bin/bash)
# 2. Open file, read into memory
# 3. Parse into tokens
# 4. Build parse tree
# 5. Expand variables, commands
# 6. Execute
```

#### Subshells

```bash
# Parentheses create subshells
(cd /tmp; ls)  # Doesn't affect parent shell

# Pipeline creates subshells
cat file | while read line; do
    # This runs in a subshell
done
# Changes to variables are lost

# Process substitution
while read line; do
    echo "$line"
done < <(grep pattern file)  # <() is a subshell
```

#### Process Substitution

```bash
# Compare two command outputs
diff <(ls /bin) <(ls /usr/bin)

# Read from command output
while read line; do
    echo "$line"
done < <(find . -type f)

# Multiple inputs
paste <(cut -f1 file1) <(cut -f2 file2)
```

### Text Processing: sed, awk, find

#### sed (Stream Editor)

```bash
# Substitute
sed 's/old/new/' file           # First occurrence per line
sed 's/old/new/g' file          # All occurrences
sed 's/old/new/2' file          # Second occurrence
sed '1s/old/new/' file          # Specific line
sed '/pattern/s/old/new/' file  # Lines matching pattern

# Delete
sed '/pattern/d' file           # Delete matching lines
sed '1,5d' file                # Delete lines 1-5

# Insert/Append
sed '1i\Header line' file      # Insert before line 1
sed '1a\After line 1' file     # Append after line 1

# Multiple commands
sed -e 's/a/A/' -e 's/b/B/' file

# In-place editing
sed -i 's/old/new/g' file
sed -i.bak 's/old/new/g' file

# Extended regex
sed -E 's/(pattern)/\1/g' file
```

#### awk

```bash
# Basic print
awk '{print $1}' file          # First field
awk '{print NF}' file         # Number of fields
awk '{print $NF}' file        # Last field

# Field separator
awk -F: '{print $1}' /etc/passwd
awk -F'[,:]' '{print $1}' file

# Patterns
awk '/pattern/ {print}' file
awk '$1 > 100 {print}' file

# Built-in variables
# FS - field separator
# OFS - output field separator
# RS - record separator
# ORS - output record separator
# NR - number of records
# NF - number of fields
# FNR - record number in file

# Process multiple files
awk 'FNR==1 {print "File:", FILENAME} {print}' file1 file2

# Arithmetic
awk '{sum+=$1} END {print sum}' file

# Arrays
awk '{count[$1]++} END {for (word in count) print word, count[word]}' file

# Functions
awk 'function max(a,b) {return a>b?a:b} {print max($1,$2)}' file
```

#### find

```bash
# Basic find
find /path -name "*.txt"
find /path -type f -name "*.log"

# Type: f=file, d=directory, l=symbolic link
find /path -type d -name "dir*"

# Modified time
find /path -mtime -7           # Modified in last 7 days
find /path -mmin -30          # Modified in last 30 minutes

# Size
find /path -size +100M        # Larger than 100MB
find /path -size -1k          # Smaller than 1KB

# Permissions
find /path -perm 644
find /path -perm -u+w

# Execute command
find /path -name "*.tmp" -delete
find /path -name "*.log" -exec wc -l {} \;
find /path -name "*.log" -exec wc -l {} +  # More efficient

# Multiple conditions
find /path \( -name "*.log" -o -name "*.txt" \)
find /path -name "*.log" -not -path "*/old/*"
```

### Here Documents and Strings

```bash
# Here document (standard input)
cat <<EOF
Hello, $NAME
Current date: $(date)
EOF

# Here document with quoted delimiter (no expansion)
cat <<'EOF'
Hello, $NAME
Variable won't expand
EOF

# Here string (single line)
read -r name <<< "John Doe"
echo "$name"

# Multiple lines to variable
read -r -d '' VAR <<EOF
Line 1
Line 2
Line 3
EOF
```

### Error Handling in Scripts

```bash
#!/bin/bash
set -euo pipefail

# -e: Exit on error
# -u: Error on undefined variables
# -o pipefail: Pipeline fails if any command fails

# Function with error handling
function safe_command() {
    set -e
    command_that_might_fail
    set +e
}

# Trap errors
trap 'echo "Error on line $LINENO"' ERR

# Check command success
if ! command; then
    echo "Command failed" >&2
    exit 1
fi

# Assert conditions
assert() {
    local msg=${2:-"Assertion failed: $1"}
    [ "$1" ] || { echo "$msg" >&2; exit 1; }
}
assert "$(id -nu)" = "root" "Must run as root"

# Cleanup on exit
cleanup() {
    rm -f "$TMPFILE"
}
trap cleanup EXIT
```

### Shell Performance

```bash
# Shebang choice matters
#!/bin/sh       # POSIX, may be dash (faster)
#!/bin/bash     # Bash (slower, more features)
#!/bin/bash -s  # Read from stdin

# Avoid external commands when possible
# Bad:
files=$(ls *.txt)           # spawns subshell, ls
count=$(echo "$files" | wc -l)

# Better:
shopt -s nullglob
files=(*.txt)               # glob expansion
count=${#files[@]}

# Use built-ins
# Bad:
echo "$var" | grep pattern
# Better:
[[ $var == *pattern* ]]

# Use printf for speed
printf '%s\n' "${array[@]}" > file

# Reduce pipeline complexity
# Bad:
cat file | grep pattern | sort | uniq
# Better:
grep pattern file | sort -u
```

## 12. Linux Hardening and Audit

### sysctl Security Tuning

```bash
# Network security
sysctl -w net.ipv4.conf.all.rp_filter=1
sysctl -w net.ipv4.conf.default.rp_filter=1
sysctl -w net.ipv4.icmp_echo_ignore_all=0
sysctl -w net.ipv4.icmp_echo_ignore_broadcasts=1
sysctl -w net.ipv4.conf.all.accept_redirects=0
sysctl -w net.ipv4.conf.default.accept_redirects=0
sysctl -w net.ipv4.conf.all.send_redirects=0
sysctl -w net.ipv4.conf.default.send_redirects=0
sysctl -w net.ipv4.conf.all.accept_source_route=0
sysctl -w net.ipv4.conf.default.accept_source_route=0
sysctl -w net.ipv6.conf.all.accept_source_route=0
sysctl -w net.ipv6.conf.default.accept_source_route=0

# Kernel hardening
sysctl -w kernel.dmesg_restrict=1
sysctl -w kernel.kptr_restrict=2
sysctl -w kernel.yama.ptrace_scope=2
sysctl -w net.core.bpf_jit_harden=2

# Make permanent
cat >> /etc/sysctl.d/99-security.conf <<EOF
# Network
net.ipv4.conf.all.rp_filter=1
net.ipv4.conf.default.rp_filter=1

# Kernel
kernel.dmesg_restrict=1
kernel.kptr_restrict=2
EOF
```

### SELinux and AppArmor

#### SELinux

```bash
# Check SELinux status
getenforce
sestatus

# Set mode
setenforce Enforcing  # or Permissive
# Make permanent in /etc/selinux/config

# Context management
ls -Z file
ps -Z

# Change context
chcon -t httpd_sys_content_t /var/www/html/file
semanage fcontext -a -t httpd_sys_content_t "/web(/.*)?"

# Boolean toggles
getsebool -a
setsebool -P httpd_can_network_connect on
```

#### AppArmor

```bash
# Check status
aa-status

# Profiles
ls /etc/apparmor.d/

# Enable/disable profile
aa-disable /etc/apparmor.d/usr.sbin.named

# Parse profile
apparmor_parser -r /etc/apparmor.d/profile-name
```

### PAM Configuration

```bash
# PAM modules
ls /lib/security/
ls /lib64/security/

# PAM config for a service
cat /etc/pam.d/login
cat /etc/pam.d/sshd

# Example: Add password complexity
# /etc/pam.d/common-password
password required pam_pwquality.so retry=3 minlen=12 dcredit=-1 ucredit=-1 lcredit=-1 ocredit=-1

# Example: Add limit
# /etc/security/limits.conf
* soft nofile 65536
* hard nofile 65536
```

### auditd Rules and Log Analysis

```bash
# Install auditd
apt install auditd  # or yum install audit

# Create rules
cat > /etc/audit/rules.d/security.rules <<EOF
# Monitor password files
-w /etc/passwd -p wa -k identity
-w /etc/shadow -p wa -k identity
-w /etc/group -p wa -k identity

# Monitor SSH
-w /etc/ssh/sshd_config -p wa -k sshd

# Monitor important commands
-a always,exit -F arch=b64 -S execve -F path=/usr/bin/wget -k malware
-a always,exit -F arch=b64 -S execve -F path=/usr/bin/curl -k malware

# Monitor /tmp
-w /tmp -p wa -k tmp_writes

# Monitor sudo usage
-w /var/log/sudo.log -p wa -k sudo
EOF

# Reload rules
auditctl -R /etc/audit/rules.d/security.rules

# View logs
ausearch -k identity
ausearch -k malware
aureport -f
aureport -u

# Real-time monitoring
tail -f /var/log/audit/audit.log
```

### File Permissions and ACLs

```bash
# Standard permissions
chmod 755 file
chmod 644 file
chmod +x file

# Special permissions
chmod u+s file      # Setuid
chmod g+s file      # Setgid
chmod +t file       # Sticky bit

# ACLs
# View ACL
getfacl file

# Set ACL
setfacl -m u:bob:rw file
setfacl -m g:admins:rwx file
setfacl -m o::r file

# Default ACL (for directories)
setfacl -R -m d:u:bob:rw /directory

# Remove ACL
setfacl -x u:bob file

# Backup/restore ACLs
getfacl -R /dir > permissions.acl
setfacl --restore=permissions.acl
```

---

## Part II: Networking

## 13. Transport Layer

### TCP: Three-Way Handshake and Sliding Window

#### Three-Way Handshake

```
Client                                    Server
  |                                          |
  |----------- SYN (seq=x) ----------------->|
  |                                          |
  |<---------- SYN-ACK (seq=y, ack=x+1) -----|
  |                                          |
  |----------- ACK (ack=y+1) --------------->
  |                                          |
  |============= ESTABLISHED ===============|
```

```bash
# Capture handshake
tcpdump -i any -nn 'tcp[tcpflags] & (tcp-syn|tcp-ack) != 0 and tcp[tcpflags] & (tcp-rst|tcp-fin) = 0'
```

#### Sliding Window

The TCP sliding window allows efficient data transfer without waiting for acknowledgments:

```
Sender Window [seq 1-5]                    [seq 6-10] → [seq 11-15]
       |                                        |           |
       v                                        v           v
   [1] [2] [3] [4] [5] → ACKed → [6] [7] [8] [9] [10] ....
        ^                              ^
        |                              |
   Sent & ACKed                 Sent, not ACKed
                                   (in-flight)
```

```bash
# View socket buffers
ss -tm

# TCP window size
cat /proc/sys/net/ipv4/tcp_rmem
cat /proc/sys/net/ipv4/tcp_wmem
```

### TCP Congestion Control

#### Algorithms

```bash
# Available algorithms
sysctl net.ipv4.tcp_available_congestion_control

# Current algorithm
sysctl net.ipv4.tcp_congestion_control

# Set BBR (better for high-latency/high-bandwidth)
sysctl net.ipv4.tcp_congestion_control=bbr
```

| Algorithm | Description | Best For |
|----------|-------------|----------|
| cubic | Default, cubic function | General purpose |
| reno | Classic, AIMD | Legacy |
| bbr | Bandwidth-delay product | High BDP |
| dctcp | Data center TCP | Low-latency DC |

#### Congestion Window

```bash
# View TCP stats
cat /proc/net/netstat

# View per-connection stats
ss -eti
```

### UDP and When to Use It

```bash
# UDP characteristics:
# - No connection establishment
# - No ordering guarantees
# - No flow control
# - Small header (8 bytes vs 20 bytes)
# - Broadcast/multicast support

# Use UDP when:
# - Loss is acceptable (streaming, gaming)
# - Low latency critical (DNS, VoIP)
# - Simple request/response (DNS, NTP)
# - Multicast needed
# - Traffic volume is high (video)
```

### Socket Options and Tuning

```bash
# Important socket options
SO_REUSEADDR    # Allow reuse of local address
SO_REUSEPORT    # Allow multiple binds to same port (load balancing)
SO_KEEPALIVE    # Enable TCP keepalive
SO_LINGER       # Close behavior
TCP_NODELAY     # Disable Nagle's algorithm
TCP_QUICKACK    # Disable delayed acknowledgments
TCP_CORK        # Hold data until full packet

# Set socket options
# In C:
int opt = 1;
setsockopt(sock, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(opt));
setsockopt(sock, IPPROTO_TCP, TCP_NODELAY, &opt, sizeof(opt));

# In sysctl:
sysctl -w net.ipv4.tcp_timestamps=1
sysctl -w net.ipv4.tcp_sack=1
sysctl -w net.ipv4.tcp_window_scaling=1
```

## 14. Application Layer

### DNS: Resolution and Records

#### DNS Record Types

| Type | Description |
|------|-------------|
| A | IPv4 address |
| AAAA | IPv6 address |
| CNAME | Canonical name (alias) |
| MX | Mail exchange |
| TXT | Text records (SPF, DKIM, DMARC) |
| NS | Name server |
| SOA | Start of authority |
| PTR | Pointer (reverse DNS) |
| SRV | Service location |

```bash
# Query DNS
dig example.com A
dig example.com MX
dig -x 8.8.8.8 PTR

# Query specific server
dig @8.8.8.8 example.com

# Reverse DNS
host 8.8.8.8
dig -x 8.8.8.8

# DNS cache
# System
systemd-resolve --flush-caches
# BIND
rndc flush
# nscd
nscd -i hosts
```

### HTTP/1.1, HTTP/2, and HTTP/3

#### HTTP/1.1
- Persistent connections (keep-alive)
- Pipelining (limited)
- Chunked transfer encoding
- Compression (optional)
- No multiplexing (head-of-line blocking)

#### HTTP/2
- Binary framing
- Multiplexing (multiple streams)
- Header compression (HPACK)
- Server push
- Stream prioritization

```bash
# HTTP/2 features
# Enable in nginx:
server {
    listen 443 ssl http2;
    # ...
}

# HTTP/2 with curl
curl --http2 https://example.com
```

#### HTTP/3
- QUIC protocol (UDP-based)
- 0-RTT connection establishment
- No head-of-line blocking
- Improved congestion control
- Built-in TLS 1.3

```bash
# HTTP/3 with curl
curl --http3 https://example.com
```

### Load Balancing Algorithms

```bash
# Round Robin (default)
# Each request goes to next server

# Least Connections
# Route to server with fewest active connections

# IP Hash
# Hash client IP to determine server

# Weighted
# Distribute based on server capacity

# Least Response Time
# Route to server with fastest response

# nginx example
upstream backend {
    least_conn;
    server 10.0.0.1 weight=3;
    server 10.0.0.2;
    server 10.0.0.3 backup;
}

# HAProxy example
backend web_backend
    balance leastconn
    server web1 10.0.0.1:80 check
    server web2 10.0.0.2:80 check
```

### CDN and Caching

```bash
# CDN concepts
# - Edge servers worldwide
# - Cache static content
# - TLS termination
# - DDoS protection
# - Origin shielding

# Cache headers
Cache-Control: max-age=3600, public
ETag: "abc123"
Last-Modified: Mon, 01 Jan 2024 00:00:00 GMT
Vary: Accept-Encoding

# CDN providers
# Cloudflare, CloudFront, Fastly, Akamai

# Cache invalidation
# CloudFront
aws cloudfront create-invalidation --distribution-id ID --paths "/*"

# Cloudflare
curl -X POST "https://api.cloudflare.com/client/v4/zones/ZONE_ID/purge_cache" \
    -H "Authorization: Bearer TOKEN" \
    -H "Content-Type: application/json" \
    --data '{"purge_everything":true}'
```

## 15. Network Security

### TLS/SSL Handshake

```
Client                                          Server
  |                                                |
  |--------------- ClientHello ------------------->|
  |            (TLS version, cipher suites)        |
  |                                                |
  |<-------------- ServerHello -------------------|
  |          (cipher, session ID)                  |
  |<------------- Certificate --------------------|
  |         (server public key)                    |
  |<------------- ServerKeyExchange -------------|
  |         (params, signature)                    |
  |<-------------- ServerHelloDone ---------------|
  |                                                |
  |--------------- ClientKeyExchange ------------>|
  |         (premaster secret, encrypted)          |
  |--------------- ChangeCipherSpec ------------->|
  |--------------- Finished --------------------->|
  |           (verify handshake)                   |
  |<-------------- ChangeCipherSpec --------------|
  |<-------------- Finished ----------------------|
  |           (verify handshake)                  |
  |                                                |
  |================ Application Data =============|
```

```bash
# Check TLS configuration
openssl s_client -connect example.com:443
openssl s_client -connect example.com:443 -tls1_2
openssl s_client -connect example.com:443 -showcerts

# Test specific cipher
openssl s_client -connect example.com:443 -cipher 'ECDHE-RSA-AES256-GCM-SHA384'

# Get certificate info
echo | openssl s_client -connect example.com:443 2>/dev/null | openssl x509 -noout -subject -issuer -dates
```

### Mutual TLS (mTLS)

```bash
# Generate CA
openssl genrsa -out ca.key 4096
openssl req -x509 -new -nodes -key ca.key -sha256 -days 365 \
    -out ca.crt -subj "/CN=MyCA"

# Generate server key and CSR
openssl genrsa -out server.key 4096
openssl req -new -key server.key -out server.csr \
    -subj "/CN=server.example.com"

# Sign server certificate
openssl x509 -req -in server.csr -CA ca.crt -CAkey ca.key \
    -CAcreateserial -out server.crt -days 365 -sha256 \
    -extfile <(echo "subjectAltName=DNS:server.example.com")

# Generate client key and CSR
openssl genrsa -out client.key 4096
openssl req -new -key client.key -out client.csr \
    -subj "/CN=client"

# Sign client certificate
openssl x509 -req -in client.csr -CA ca.crt -CAkey ca.key \
    -CAcreateserial -out client.crt -days 365 -sha256

# Verify
openssl verify -CAfile ca.crt server.crt
openssl verify -CAfile ca.crt client.crt
```

### SSH Tunneling and Port Forwarding

```bash
# Local port forwarding
# Access remote service through SSH tunnel
ssh -L 8080:localhost:80 user@remote

# Remote port forwarding
# Expose local service to remote
ssh -R 8080:localhost:80 user@remote

# Dynamic port forwarding (SOCKS proxy)
ssh -D 1080 user@remote

# SSH jump host
ssh -J jump1,jump2 user@target

# SSH config
# ~/.ssh/config
Host target
    HostName target.example.com
    User admin
    ProxyJump jump.example.com
    IdentityFile ~/.ssh/id_rsa
    ForwardAgent yes

# Keepalive
# /etc/ssh/ssh_config
ServerAliveInterval 60
ServerAliveCountMax 3
```

### VPN Protocols

#### WireGuard

```bash
# Install
apt install wireguard

# Generate keys
wg genkey | tee private.key | wg pubkey > public.key

# Server config /etc/wireguard/wg0.conf
[Interface]
Address = 10.0.0.1/24
ListenPort = 51820
PrivateKey = SERVER_PRIVATE_KEY
PostUp = iptables -A FORWARD -i wg0 -j ACCEPT
PostUp = iptables -A POSTROUTING -t nat -o eth0 -j MASQUERADE
PostDown = iptables -D FORWARD -i wg0 -j ACCEPT
PostDown = iptables -D POSTROUTING -t nat -o eth0 -j MASQUERADE

[Peer]
PublicKey = CLIENT_PUBLIC_KEY
AllowedIPs = 10.0.0.2/32

# Client config
[Interface]
Address = 10.0.0.2/24
PrivateKey = CLIENT_PRIVATE_KEY

[Peer]
PublicKey = SERVER_PUBLIC_KEY
Endpoint = server.example.com:51820
AllowedIPs = 0.0.0.0/0
PersistentKeepalive = 25
```

#### OpenVPN

```bash
# Install
apt install openvpn easy-rsa

# Generate keys
cd /usr/share/easy-rsa
./easyrsa init-pki
./easyrsa build-ca
./easyrsa build-server-full server nopass
./easyrsa build-client-full client nopass
./easyrsa gen-dh

# Server config
dev tun
proto udp
port 1194
ca pki/ca.crt
cert pki/issued/server.crt
key pki/private/server.key
dh pki/dh.pem
server 10.8.0.0 255.255.255.0
push "redirect-gateway def1 bypass-dhcp"
keepalive 10 60
persist-key
persist-tun
cipher AES-256-GCM
auth SHA256

# Start
systemctl start openvpn@server
```

## 16. High Availability and Load Balancing

### HAProxy Deep Dive

```haproxy
# /etc/haproxy/haproxy.cfg
global
    log /dev/log local0
    log /dev/log local1 notice
    chroot /var/lib/haproxy
    stats socket /run/haproxy/admin.sock mode 660 level admin
    stats timeout 30s
    user haproxy
    group haproxy
    daemon
    maxconn 4000

defaults
    log     global
    mode    http
    option  httplog
    option  dontlognull
    option  http-server-close
    option  forwardfor except 127.0.0.0/8
    option  redispatch
    retries 3
    timeout connect 5000
    timeout client  50000
    timeout server  50000
    errorfile 400 /etc/haproxy/errors/400.http
    errorfile 403 /etc/haproxy/errors/403.http
    errorfile 408 /etc/haproxy/errors/408.http
    errorfile 500 /etc/haproxy/errors/500.http
    errorfile 502 /etc/haproxy/errors/502.http
    errorfile 503 /etc/haproxy/errors/503.http
    errorfile 504 /etc/haproxy/errors/504.http

frontend http_front
    bind *:80
    bind *:443 ssl crt /etc/ssl/certs/server.pem
    http-response set-header X-Frame-Options "SAMEORIGIN"
    http-response set-header X-Content-Type-Options "nosniff"
    default_backend web_backend

backend web_backend
    balance roundrobin
    option httpchk GET /health
    http-check expect status 200
    server web1 10.0.0.1:80 check inter 2000 rise 2 fall 3
    server web2 10.0.0.2:80 check inter 2000 rise 2 fall 3
    server web3 10.0.0.3:80 check inter 2000 rise 2 fall 3

frontend stats_front
    bind *:8404
    stats enable
    stats uri /stats
    stats refresh 30s
    stats admin if TRUE
```

### NGINX Load Balancing

```nginx
# /etc/nginx/nginx.conf
events {
    worker_connections 1024;
}

http {
    upstream backend {
        least_conn;
        server 10.0.0.1:80 weight=3;
        server 10.0.0.2:80;
        server 10.0.0.3:80 backup;
        keepalive 32;
    }

    server {
        listen 80;
        listen 443 ssl http2;
        
        ssl_certificate /etc/ssl/certs/server.crt;
        ssl_certificate_key /etc/ssl/certs/server.key;
        ssl_protocols TLSv1.2 TLSv1.3;
        ssl_ciphers ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256;
        
        location / {
            proxy_pass http://backend;
            proxy_http_version 1.1;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
            proxy_connect_timeout 5s;
            proxy_send_timeout 60s;
            proxy_read_timeout 60s;
        }
        
        location /health {
            access_log off;
            return 200 "OK\n";
        }
    }
}
```

### Health Checks

```bash
# HAProxy health check configuration
backend web_backend
    option httpchk
    http-check send meth GET uri /health hdr Host example.com
    http-check expect status 200,204,301,302,303,401,403
    server web1 10.0.0.1:80 check inter 2000 rise 2 fall 3
    # inter: check interval (ms)
    # rise: successful checks before marked healthy
    # fall: failed checks before marked unhealthy

# NGINX health check (with nginx-upstream-check-module)
upstream backend {
    server 10.0.0.1:80;
    check interval=2000 rise=2 fall=3 timeout=1000 type=http;
    check_http_send "GET /health HTTP/1.0\r\n\r\n";
    check_http_expect_alive http_2xx;
}
```

### Circuit Breakers

```nginx
# NGINX limit connections
limit_conn_zone $binary_remote_addr zone=addr:10m;

server {
    location / {
        limit_conn addr 10;
        proxy_pass http://backend;
    }
}

# HAProxy circuit breaker
backend web_backend
    http-check expect status 200
    server web1 10.0.0.1:80 check inter 2000 rise 2 fall 3 slowstart 30s
    server web2 10.0.0.2:80 check inter 2000 rise 2 fall 3 slowstart 30s
```

### Rate Limiting

```nginx
# NGINX rate limiting
http {
    limit_req_zone $binary_remote_addr zone=mylimit:10m rate=10r/s;
    limit_req_zone $binary_remote_addr zone=apilimit:10m rate=100r/s;
    
    server {
        location / {
            limit_req zone=mylimit burst=20 nodelay;
        }
        
        location /api/ {
            limit_req zone=apilimit burst=50 nodelay;
        }
    }
}
```

```haproxy
# HAProxy rate limiting
frontend http_front
    http-request track-sc0 src table per_ip_rates
    http-request deny if { sc_http_req_rate(0) gt 50 }

backend per_ip_rates
    stick-table type ip size 100k expire 30s store http_req_rate(30s)
```

---

## Part III: Cryptography

## 17. Cryptographic Primitives

### Symmetric Encryption: AES

```python
from cryptography.hazmat.primitives.ciphers import Cipher, algorithms, modes
from cryptography.hazmat.backends import default_backend
import os

# AES-256-GCM (authenticated encryption)
key = os.urandom(32)  # 256 bits
iv = os.urandom(12)    # 96 bits (recommended for GCM)

cipher = Cipher(
    algorithms.AES(key),
    modes.GCM(iv),
    backend=default_backend()
)

encryptor = cipher.encryptor()
ciphertext = encryptor.update(b"Hello, World!") + encryptor.finalize()

# The tag is automatically appended to ciphertext in GCM mode
# For separate tag:
# tag = encryptor.tag

# Decryption
cipher = Cipher(
    algorithms.AES(key),
    modes.GCM(iv, encryptor.tag),
    backend=default_backend()
)
decryptor = cipher.decryptor()
plaintext = decryptor.update(ciphertext) + decryptor.finalize()
print(plaintext)  # b'Hello, World!'
```

#### AES Modes

| Mode | Description | Use Case |
|------|-------------|----------|
| ECB | Electronic Codebook | ❌ Not secure for messages |
| CBC | Cipher Block Chaining | Legacy, needs padding |
| CTR | Counter | Parallelizable |
| GCM | Galois/Counter | ✓ Recommended, authenticated |
| XTS | XEX-based | Disk encryption |

### Asymmetric Encryption: RSA, ECDH, Ed25519

```python
from cryptography.hazmat.primitives.asymmetric import rsa, ec
from cryptography.hazmat.primitives import hashes, serialization
from cryptography.hazmat.primitives.kdf.hkdf import HKDF

# RSA
private_key = rsa.generate_private_key(
    public_exponent=65537,
    key_size=2048,
    backend=default_backend()
)
public_key = private_key.public_key()

# Encrypt (with OAEP)
ciphertext = public_key.encrypt(
    b"message",
    padding.OAEP(
        mgf=padding.MGF1(algorithm=hashes.SHA256()),
        algorithm=hashes.SHA256(),
        label=None
    )
)

# Decrypt
plaintext = private_key.decrypt(
    ciphertext,
    padding.OAEP(
        mgf=padding.MGF1(algorithm=hashes.SHA256()),
        algorithm=hashes.SHA256(),
        label=None
    )
)

# ECDH (Elliptic Curve Diffie-Hellman)
private_key = ec.generate_private_key(ec.SECP256R1())
public_key = private_key.public_key()

# Key exchange
shared_key = private_key.exchange(ec.ECDH(), public_key)

# Ed25519 (signing only)
from cryptography.hazmat.primitives.asymmetric import ed25519

private_key = ed25519.Ed25519PrivateKey.generate()
public_key = private_key.public_key()

signature = private_key.sign(b"message")
public_key.verify(signature, b"message")
```

### Hashing: SHA-2, SHA-3, bcrypt, Argon2

```python
from cryptography.hazmat.primitives import hashes
from cryptography.hazmat.primitives.kdf.pbkdf2 import PBKDF2HMAC
import hashlib
import bcrypt
from argon2 import PasswordHasher

# SHA-256
h = hashlib.sha256(b"message").hexdigest()

# SHA-512
h = hashlib.sha512(b"message").hexdigest()

# PBKDF2 (key derivation)
kdf = PBKDF2HMAC(
    algorithm=hashes.SHA256(),
    length=32,
    salt=b"salt",
    iterations=100000,
    backend=default_backend()
)
key = kdf.derive(b"password")

# bcrypt (password hashing)
hashed = bcrypt.hash(b"password", rounds=12)
bcrypt.checkpw(b"password", hashed)

# Argon2 (better than bcrypt)
ph = PasswordHasher()
hashed = ph.hash("password")
ph.verify(hashed, "password")
```

### MACs and HMACs

```python
import hmac
from cryptography.hazmat.primitives import hashes, cmac
from cryptography.hazmat.primitives.ciphers import Cipher, algorithms, modes

# HMAC
key = b"secret"
message = b"message"
signature = hmac.new(key, message, hashlib.sha256).digest()

# Verify HMAC
expected = hmac.new(key, message, hashlib.sha256).digest()
assert hmac.compare_digest(signature, expected)

# CMAC (Cipher-based MAC)
key = os.urandom(16)
cmac = cmac.CMAC(algorithms.AES(key), backend=default_backend())
cmac.update(b"message")
signature = cmac.finalize()
```

### Entropy and Randomness

```python
import os
import secrets

# Cryptographically secure random
random_bytes = os.urandom(32)  # Use for keys

# secrets module (Python 3.6+)
token = secrets.token_urlsafe(32)
token_hex = secrets.token_hex(16)

# Token for reset (timing-safe comparison)
def check_reset_token(user_token, stored_hash):
    return hmac.compare_digest(user_token, stored_hash)

# Random number in range
num = secrets.randbelow(100)
choices = secrets.choice(['a', 'b', 'c'])

# /dev/urandom vs /dev/random
# /dev/urandom: Always returns data (pools entropy)
# /dev/random: Blocks when low entropy (may block)
# Use /dev/urandom for cryptographic purposes
```

## 18. PKI and Certificates

### X.509 Certificate Structure

```
Certificate:
  Data:
    Version: v3
    Serial Number: 1234567890
    Signature Algorithm: sha256WithRSAEncryption
    Issuer: CN=MyCA, O=MyOrg
    Validity:
      Not Before: 2024-01-01 00:00:00
      Not After: 2025-01-01 00:00:00
    Subject: CN=server.example.com
    Subject Public Key Info:
      Algorithm: RSA
      Public Key: (2048-bit)
    Extensions:
      Subject Alternative Name: DNS:example.com
      Key Usage: Digital Signature, Key Encipherment
      Extended Key Usage: Server Auth
  Signature Algorithm: sha256WithRSAEncryption
  Signature: (signature bytes)
```

```bash
# View certificate
openssl x509 -in cert.crt -text -noout
openssl x509 -in cert.crt -subject -issuer -dates

# Check certificate chain
openssl verify -CAfile ca.crt server.crt

# Extract info
openssl x509 -in cert.crt -noout -serial
openssl x509 -in cert.crt -noout -fingerprint -sha256
```

### Certificate Chains and CA Hierarchy

```bash
# Create multi-level CA hierarchy
# Root CA (self-signed)
openssl genrsa -out root-ca.key 4096
openssl req -x509 -new -nodes -key root-ca.key -sha256 -days 3650 \
    -out root-ca.crt -subj "/CN=RootCA/O=MyOrg"

# Intermediate CA (signed by Root)
openssl genrsa -out intermediate-ca.key 4096
openssl req -new -key intermediate-ca.key -out intermediate-ca.csr \
    -subj "/CN=IntermediateCA/O=MyOrg"
openssl x509 -req -in intermediate-ca.csr -CA root-ca.crt -CAkey root-ca.key \
    -CAcreateserial -out intermediate-ca.crt -days 1825 -sha256 \
    -extfile <(echo "basicConstraints=critical,CA:TRUE,pathlen:0")

# Server certificate (signed by Intermediate)
openssl genrsa -out server.key 2048
openssl req -new -key server.key -out server.csr \
    -subj "/CN=server.example.com"
openssl x509 -req -in server.csr -CA intermediate-ca.crt -CAkey intermediate-ca.key \
    -CAcreateserial -out server.crt -days 365 -sha256 \
    -extfile <(echo "subjectAltName=DNS:example.com,DNS:www.example.com")

# Create full chain
cat server.crt intermediate-ca.crt > server-chain.crt
```

### CSR Generation and Self-Signed Certificates

```bash
# Generate private key and CSR
openssl req -newkey rsa:2048 -nodes -keyout server.key \
    -out server.csr -subj "/CN=example.com/O=MyOrg"

# Add alternative names
cat > extfile.cnf <<EOF
subjectAltName = DNS:example.com,DNS:www.example.com
keyUsage = digitalSignature, keyEncipherment
extendedKeyUsage = serverAuth
EOF

# Create self-signed certificate
openssl req -x509 -new -nodes -key server.key -sha256 -days 365 \
    -out server.crt -subj "/CN=example.com" -extfile extfile.cnf

# Sign CSR with CA
openssl x509 -req -in server.csr -CA ca.crt -CAkey ca.key \
    -CAcreateserial -out server.crt -days 365 -sha256 -extfile extfile.cnf
```

### Certificate Rotation and ACME

```bash
# certbot (Let's Encrypt)
certbot certonly --webroot -w /var/www/html -d example.com
certbot renew --dry-run

# Manual ACME
# 1. Create account
curl -X POST https://acme-v02.api.letsencrypt.org/directory \
    -H "Content-Type: application/jose+json" \
    --data '{"termsOfServiceAgreed": true}'

# 2. Get challenges
curl -X POST https://acme-v02.api.letsencrypt.org/acme/new-order \
    -H "Authorization: Bearer TOKEN" \
    -d '{"identifiers":[{"type":"dns","value":"example.com"}]}'

# 3. Respond to HTTP-01 challenge
# PUT challenge response to .well-known/acme-challenge/

# 4. Validate and get certificate
curl -X POST https://acme-v02.api.letsencrypt.org/acme/order/ORDER_ID/finalize \
    -d '{"csr":"BASE64_CSR"}'
```

### CRL vs OCSP

```bash
# CRL (Certificate Revocation List)
# Download entire list periodically
openssl ca -gencrl -out revoked.crl
openssl crl -in revoked.crl -text -noout

# OCSP (Online Certificate Status Protocol)
# Real-time check
openssl ocsp -issuer ca.crt -cert server.crt \
    -url http://ocsp.example.com -CAfile ca.crt -no_nonce

# Nginx OCSP stapling
ssl_stapling on;
ssl_stapling_verify on;
resolver 8.8.8.8;
```

## 19. Secrets Management

### HashiCorp Vault: Transit Secrets

```bash
# Enable transit secret engine
vault secrets enable -path=transit transit

# Create encryption key
vault write -f transit/keys/my-key

# Encrypt data
vault write transit/encrypt/my-key plaintext=$(echo -n "secret" | base64)

# Decrypt
vault write transit/decrypt/my-key ciphertext="..."

# Rotate key
vault write -f transit/keys/my-key/rotate
```

```python
import hvac

client = hvac.Client(url='http://vault:8200', token='token')

# Encrypt
response = client.secrets.transit.encrypt_data(
    path='my-key',
    plaintext='Hello, World!'
)
ciphertext = response['data']['ciphertext']

# Decrypt
response = client.secrets.transit.decrypt_data(
    path='my-key',
    ciphertext=ciphertext
)
plaintext = response['data']['plaintext']
```

### Vault PKI and Dynamic Secrets

```bash
# Enable PKI secret engine
vault secrets enable pki
vault secrets tune -max-lease-ttl=87600 pki

# Generate root CA
vault write pki/root/general/intermediate \
    type=exported \
    common_name="My Root CA" \
    ttl=87600

# Create intermediate CA
vault secrets enable -path=pki_int pki
vault write pki_int/intermediate/generate/internal \
    common_name="My Intermediate CA" \
    ttl=43800

# Issue certificates dynamically
vault write pki_int/issue/server \
    common_name="server.example.com" \
    ttl=24h \
    alt_names="server.example.com" \
    ip_sans="10.0.0.1"

# Database dynamic secrets
vault secrets enable database
vault write database/config/my-db \
    plugin_name=postgresql-database-plugin \
    connection_url="postgresql://{{username}}:{{password}}@localhost:5432/db" \
    allowed_roles="app-role"

vault write database/roles/app-role \
    db_name=my-db \
    creation_statements="CREATE ROLE ..." \
    default_ttl=1h \
    max_ttl=24h
```

### Kubernetes Secrets

```yaml
# Create secret
apiVersion: v1
kind: Secret
metadata:
  name: my-secret
type: Opaque
stringData:
  username: admin
  password: changeme
---
# Use in pod
apiVersion: v1
kind: Pod
metadata:
  name: my-pod
spec:
  containers:
  - name: app
    image: myapp
    env:
    - name: DB_PASSWORD
      valueFrom:
        secretKeyRef:
          name: my-secret
          key: password
```

```bash
# Encrypt secrets at rest (in etcd)
# Using encryption configuration
apiVersion: apiserver.config.k8s.io/v1
kind: EncryptionConfiguration
resources:
- providers:
  - aescbc:
      keys:
      - name: key1
        secret: <base64-encoded-key>
  - identity: {}
  resources:
  - secrets
```

### Cloud Secret Managers

```python
# AWS Secrets Manager
import boto3
import json

client = boto3.client('secretsmanager')

# Get secret
response = client.get_secret_value(SecretId='my-secret')
secret = json.loads(response['SecretString'])

# Rotate secret
client.rotate_secret(
    SecretId='my-secret',
    RotationLambdaARN='arn:aws:lambda:region:account:function:rotate'
)

# GCP Secret Manager
from google.cloud import secretmanager

client = secretmanager.SecretManagerServiceClient()

# Access secret
name = f"projects/{project}/secrets/{secret}/versions/latest"
response = client.access_secret_version(name=name)
secret = response.payload.data.decode('UTF-8')
```

### SOPS and age Encryption

```bash
# Install SOPS
go install github.com/mozilla/sops@latest

# Create encryption key
age-keygen -o key.txt

# Create .sops.yaml
cat > .sops.yaml <<EOF
creation_rules:
  - path_regex: \.env$
    age: <public-key-from-age-keygen>
  - path_regex: secrets\.yaml$
    age: <public-key>
EOF

# Encrypt file
sops -e secrets.yaml > secrets.encrypted.yaml

# Decrypt file
sops -d secrets.encrypted.yaml

# Edit encrypted file
sops secrets.encrypted.yaml
```

---

## Part IV: Containerization

## 20. Docker Deep Dive

### Container Runtime Internals

Docker uses Linux kernel features for isolation:

#### Namespaces

```bash
# View namespaces for a container
ls -la /proc/$(pgrep dockerd)/ns/

# Container's namespace
docker exec container ls -la /proc/self/ns/

# Types of namespaces
# - pid: Process IDs
# - net: Network stack
# - ipc: Inter-process communication
# - mnt: Filesystem mounts
# - user: User IDs
# - uts: Hostname
```

#### cgroups

```bash
# View cgroups for container
docker inspect container --format '{{.HostConfig.CgroupParent}}'

# CPU limits
docker run --cpus=1.5 --cpu-period=100000 --cpu-quota=150000

# Memory limits
docker run --memory=512m --memory-swap=1g

# Block I/O limits
docker run --device-read-bps /dev/sda:10mb --device-write-bps /dev/sda:10mb
```

### Docker Daemon and containerd

```bash
# Docker architecture
# dockerd (daemon)
#   └── containerd (runtime)
#       └── containerd-shim
#           └── runc (process creator)

# Docker daemon configuration
# /etc/docker/daemon.json
{
  "storage-driver": "overlay2",
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "10m",
    "max-file": "3"
  },
  "registry-mirrors": ["https://mirror.gcr.io"],
  "insecure-registries": ["myregistry:5000"],
  "live-restore": true
}

# Manage containerd
systemctl status containerd
ctr images list
crictl images
```

### Image Layers and Storage Drivers

```bash
# View image layers
docker history nginx:latest

# View container filesystem layers
docker diff container

# Storage drivers
# overlay2 (recommended)
# - Uses overlay filesystem
# - Good performance
# - Works with nested containers

# devicemapper
# - Legacy
# - Uses device mapper thin provisioning

# btrfs
# - Copy-on-write
# - Good for read-heavy workloads

# zfs
# - Advanced features
# - Memory intensive
```

### BuildKit and Multi-Stage Builds

```dockerfile
# Multi-stage build example
# Build stage
FROM golang:1.21 AS builder
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o app

# Runtime stage
FROM alpine:3.18
RUN apk --no-cache add ca-certificates
WORKDIR /app
COPY --from=builder /app/app .
EXPOSE 8080
CMD ["./app"]
```

```bash
# Enable BuildKit
export DOCKER_BUILDKIT=1

# Or use docker buildx
docker buildx create --use
docker buildx build -t myapp .
```

### Docker Networking

```bash
# Network drivers
# bridge: Default, isolated network
# host: Share host's network stack
# overlay: Multi-host networking
# macvlan: Direct hardware access
# none: No networking

# Create custom network
docker network create --driver bridge mynetwork

# Run container in network
docker run --network mynetwork --name mycontainer myimage

# Inspect network
docker network inspect mynetwork

# Connect running container to network
docker network connect mynetwork container

# Port mapping
docker run -p 8080:80 nginx  # host:container
docker run -p 127.0.0.1::80 nginx  # localhost only
```

### Volumes and Bind Mounts

```bash
# Named volume
docker volume create mydata
docker run -v mydata:/data myimage

# Bind mount
docker run -v /host/path:/container/path:ro myimage

# tmpfs mount (memory)
docker run --tmpfs /tmp:rw,size=100m myimage

# View volumes
docker volume ls
docker volume inspect mydata

# Remove unused volumes
docker volume prune
```

### Container Security

```bash
# Run as non-root
docker run -u 1000:1000 myimage

# Read-only root filesystem
docker run --read-only myimage

# Drop capabilities
docker run --cap-drop ALL --cap-add NET_BIND_SERVICE myimage

# Seccomp profile
docker run --security-opt seccomp=default myimage

# AppArmor profile
docker run --security-opt apparmor=docker-default myimage

# Selinux
docker run --security-opt label=type:container_runtime_t myimage

# Scan images
trivy image myimage
docker scout cves myimage
```

## 21. Docker Compose

### Compose File Syntax

```yaml
version: '3.8'

services:
  app:
    build:
      context: .
      dockerfile: Dockerfile
    image: myapp:latest
    container_name: myapp
    ports:
      - "8080:8080"
    environment:
      - NODE_ENV=production
      - DB_HOST=db
    env_file:
      - .env.production
    volumes:
      - ./data:/app/data
      - app-cache:/app/cache
    depends_on:
      db:
        condition: service_healthy
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:8080/health"]
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 40s
    networks:
      - frontend
      - backend
    restart: unless-stopped
    deploy:
      resources:
        limits:
          cpus: '0.5'
          memory: 512M
        reservations:
          cpus: '0.25'
          memory: 256M

  db:
    image: postgres:15
    environment:
      POSTGRES_DB: app
      POSTGRES_USER: user
      POSTGRES_PASSWORD: password
    volumes:
      - db-data:/var/lib/postgresql/data
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U user -d app"]
      interval: 10s
      timeout: 5s
      retries: 5
    networks:
      - backend

volumes:
  app-cache:
  db-data:

networks:
  frontend:
    driver: bridge
  backend:
    driver: bridge
```

### Service Dependencies and Healthchecks

```bash
# Start services in order
docker-compose up -d

# Wait for service to be healthy
# depends_on with condition
services:
  app:
    depends_on:
      db:
        condition: service_healthy

# View service health
docker-compose ps

# View logs
docker-compose logs -f app
```

---

## Part V: Kubernetes

## 22. Kubernetes Architecture

### Control Plane Components

```
┌─────────────────────────────────────────┐
│           Control Plane                │
├─────────────────────────────────────────┤
│  ┌─────────────┐  ┌─────────────────┐  │
│  │ API Server  │  │    etcd         │  │
│  │ (kube-ap)   │──│ (persistent)    │  │
│  └─────────────┘  └─────────────────┘  │
│  ┌─────────────┐  ┌─────────────────┐  │
│  │ Controller │  │   Scheduler     │  │
│  │ Manager    │  │   (kube-sched)  │  │
│  └─────────────┘  └─────────────────┘  │
└─────────────────────────────────────────┘
```

```bash
# View control plane pods
kubectl get pods -n kube-system

# API server
kubectl get --raw /api/v1

# View etcd
kubectl exec -n kube-system etcd-control-plane -- etcdctl \
    --endpoints=https://127.0.0.1:2379 \
    --cacert=/etc/kubernetes/pki/etcd/ca.crt \
    --cert=/etc/kubernetes/pki/etcd/server.crt \
    --key=/etc/kubernetes/pki/etcd/server.key \
    get /registry --keys --print-zeros | head
```

### Worker Nodes and Kubelet

```bash
# View nodes
kubectl get nodes -o wide

# Node details
kubectl describe node node-name

# View kubelet status
systemctl status kubelet
journalctl -u kubelet -n 100

# Node resources
kubectl top nodes
```

### Pod Lifecycle

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: my-pod
spec:
  initContainers:
  - name: init
    image: busybox:1.36
    command: ['sh', '-c', 'echo Init complete']
  containers:
  - name: main
    image: nginx:1.25
    lifecycle:
      postStart:
        exec:
          command: ["/bin/sh", "-c", "echo Started"]
      preStop:
        exec:
          command: ["/bin/sh", "-c", "nginx -s quit; sleep 5"]
    readinessProbe:
      httpGet:
        path: /healthz
        port: 80
      initialDelaySeconds: 5
      periodSeconds: 10
    livenessProbe:
      exec:
        command: ["cat", "/tmp/healthy"]
      initialDelaySeconds: 15
      periodSeconds: 20
    resources:
      requests:
        memory: "64Mi"
        cpu: "250m"
      limits:
        memory: "128Mi"
        cpu: "500m"
```

## 23. Workload Resources

### Deployments: Rolling Updates and Rollbacks

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: myapp
spec:
  replicas: 3
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 0
  selector:
    matchLabels:
      app: myapp
  template:
    metadata:
      labels:
        app: myapp
    spec:
      containers:
      - name: myapp
        image: myapp:1.0
        ports:
        - containerPort: 8080
```

```bash
# Rolling update
kubectl set image deployment/myapp myapp=myapp:2.0

# Check rollout status
kubectl rollout status deployment/myapp

# View rollout history
kubectl rollout history deployment/myapp

# Rollback
kubectl rollout undo deployment/myapp
kubectl rollout undo deployment/myapp --to-revision=2

# Pause/resume rollout
kubectl rollout pause deployment/myapp
kubectl rollout resume deployment/myapp
```

## 24. Networking and Services

### CNI Plugins

Container Network Interface (CNI) plugins define how containers communicate across nodes.

```bash
# Common CNI plugins
# - Calico: Policy-based networking, BGP
# - Cilium: eBPF-based, HTTP-aware filtering
# - Flannel: Simple, overlay networking
# - Weave Net: Mesh overlay

# Check current CNI
kubectl get pods -n kube-system | grep cni
```

### Service Types

```yaml
apiVersion: v1
kind: Service
metadata:
  name: my-service
spec:
  # ClusterIP - internal only
  type: ClusterIP
  selector:
    app: myapp
  ports:
  - port: 80
    targetPort: 8080

---
# NodePort - accessible on each node's IP
apiVersion: v1
kind: Service
metadata:
  name: my-service
spec:
  type: NodePort
  selector:
    app: myapp
  ports:
  - port: 80
    targetPort: 8080
    nodePort: 30080

---
# LoadBalancer - external LB
apiVersion: v1
kind: Service
metadata:
  name: my-service
spec:
  type: LoadBalancer
  selector:
    app: myapp
  ports:
  - port: 80
    targetPort: 8080

---
# ExternalName - DNS CNAME
apiVersion: v1
kind: Service
metadata:
  name: my-service
spec:
  type: ExternalName
  externalName: external.example.com
```

### Ingress Controllers

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: my-ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  ingressClassName: nginx
  rules:
  - host: example.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: my-service
            port:
              number: 80
```

### NetworkPolicies

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: api-allow
spec:
  podSelector:
    matchLabels:
      app: api
  policyTypes:
  - Ingress
  - Egress
  ingress:
  - from:
    - podSelector:
        matchLabels:
          app: frontend
    ports:
    - protocol: TCP
      port: 8080
  egress:
  - to:
    - podSelector:
        matchLabels:
          app: database
    ports:
    - protocol: TCP
      port: 5432
```

## 25. Configuration and Storage

### ConfigMaps and Secrets

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
data:
  database_url: "postgres://db:5432/app"
  cache_enabled: "true"
---
apiVersion: v1
kind: Secret
metadata:
  name: db-credentials
type: Opaque
stringData:
  username: admin
  password: changeme
```

### PersistentVolumes and Claims

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: my-pv
spec:
  capacity:
    storage: 10Gi
  accessModes:
    - ReadWriteOnce
  storageClassName: standard
  hostPath:
    path: /mnt/data

---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: my-pvc
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 5Gi
  storageClassName: standard
```

### StorageClasses

```yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: fast
provisioner: kubernetes.io/gce-pd
parameters:
  type: pd-ssd
  replication-type: regional-pd
reclaimPolicy: Retain
```

## 26. Kubernetes Security

### RBAC: ServiceAccounts and Roles

```yaml
# ServiceAccount
apiVersion: v1
kind: ServiceAccount
metadata:
  name: myapp-sa
  namespace: myapp-ns
---
# Role (namespace-scoped)
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: myapp-reader
rules:
- apiGroups: [""]
  resources: ["pods", "services"]
  verbs: ["get", "list", "watch"]
- apiGroups: [""]
  resources: ["pods/log"]
  verbs: ["get", "list"]
---
# RoleBinding
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: myapp-reader-binding
subjects:
- kind: ServiceAccount
  name: myapp-sa
  namespace: myapp-ns
roleRef:
  kind: Role
  name: myapp-reader
  apiGroup: rbac.authorization.k8s.io
---
# ClusterRole (cluster-scoped)
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: myapp-cluster-reader
rules:
- apiGroups: [""]
  resources: ["nodes"]
  verbs: ["get", "list", "watch"]
```

## 27. Helm and Package Management

### Helm Chart Structure

```bash
# Chart structure
mychart/
├── Chart.yaml          # Chart metadata
├── values.yaml         # Default values
├── values.schema.json  # Values validation
├── charts/            # Sub-charts
├── templates/         # Kubernetes manifests
│   ├── deployment.yaml
│   ├── service.yaml
│   ├── _helpers.tpl   # Template helpers
│   └── NOTES.txt      # Installation notes
└── crds/              # Custom Resource Definitions
```

```yaml
# Chart.yaml
apiVersion: v2
name: mychart
description: My application chart
type: application
version: 1.0.0
appVersion: "1.0"
keywords:
  - myapp
  - web
maintainers:
  - name: Maintainer
    email: maintainer@example.com
dependencies:
  - name: postgresql
    version: "12.x.x"
    repository: "https://charts.bitnami.com/bitnami"
    condition: postgresql.enabled
```

```bash
# Install chart
helm install myrelease mychart/
helm install myrelease mychart/ --set image.tag=v2.0

# Upgrade
helm upgrade myrelease mychart/

# Rollback
helm rollback myrelease 1

# Template rendering
helm template myrelease mychart/
helm template myrelease mychart/ --debug
```

---

## Part VI: Observability

## 28. Metrics

### Prometheus Architecture

```
┌──────────────────────────────────────────┐
│            Prometheus Server            │
│  ┌─────────────┐   ┌─────────────────┐  │
│  │ ServiceDisc│   │   Storage (TSDB)│  │
│  │ Scrape     │   │                 │  │
│  └─────────────┘   └─────────────────┘  │
└──────────────────────────────────────────┘
        ↑                    ↓
        │         ┌──────────┴──────────┐
        │         │                     │
┌───────┴───┐ ┌───┴────┐ ┌────────────┐  │
│ Exporters │ │ Push   │ │ Alertmanager│
│ Node      │ │ Gateway│ │             │
└───────────┘ └────────┘ └─────────────┘
```

```bash
# Prometheus configuration
global:
  scrape_interval: 15s
  evaluation_interval: 15s

alerting:
  alertmanagers:
    - static_configs:
        - targets:
          - alertmanager:9093

rule_files:
  - "rules/*.yml"

scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['localhost:9090']

  - job_name: 'node'
    static_configs:
      - targets: ['node-exporter:9100']

  - job_name: 'kubernetes-apiservers'
    kubernetes_sd_configs:
      - role: endpoints
    scheme: https
    tls_config:
      ca_file: /var/run/secrets/kubernetes.io/serviceaccount/ca.crt
    bearer_token_file: /var/run/secrets/kubernetes.io/serviceaccount/token
```

### PromQL Deep Dive

```promql
# Simple queries
node_cpu_seconds_total{mode="idle"}
node_memory_MemAvailable_bytes / node_memory_MemTotal_bytes * 100

# Rate and increase
rate(http_requests_total[5m])
increase(http_requests_total[1h])

# Aggregations
sum(rate(http_requests_total[5m])) by (job, status)
avg(node_cpu_seconds_total) by (mode)

# Histograms
histogram_quantile(0.95, rate(http_request_duration_seconds_bucket[5m]))

# Subqueries
max_over_time(rate(http_requests_total[1m])[30m:5m])

# Recording rules
# groups:
# - name: http_requests
#   rules:
#   - expr: sum(rate(http_requests_total[5m])) by (job)
#     record: job:http_requests:rate5m
```

## 29. Logging

### Structured Logging

```python
import logging
import json
import sys

class JSONFormatter(logging.Formatter):
    def format(self, record):
        log_data = {
            "timestamp": self.formatTime(record),
            "level": record.levelname,
            "message": record.getMessage(),
            "module": record.module,
            "function": record.funcName,
            "line": record.lineno,
        }
        if record.exc_info:
            log_data["exception"] = self.formatException(record.exc_info)
        return json.dumps(log_data)

logger = logging.getLogger("myapp")
handler = logging.StreamHandler(sys.stdout)
handler.setFormatter(JSONFormatter())
logger.addHandler(handler)
logger.setLevel(logging.INFO)

logger.info("User logged in", extra={"user_id": 123, "ip": "10.0.0.1"})
```

## 30. Distributed Tracing

### OpenTelemetry

```python
from opentelemetry import trace
from opentelemetry.sdk.trace import TracerProvider
from opentelemetry.sdk.trace.export import BatchSpanProcessor
from opentelemetry.exporter.jaeger.thrift import JaegerExporter
from opentelemetry.sdk.resources import Resource, SERVICE_NAME

# Setup
resource = Resource(attributes={SERVICE_NAME: "myapp"})
provider = TracerProvider(resource=resource)
trace.set_tracer_provider(provider)

jaeger_exporter = JaegerExporter(
    agent_host_name="jaeger",
    agent_port=6831,
)
provider.add_span_processor(BatchSpanProcessor(jaeger_exporter))

tracer = trace.get_tracer(__name__)

# Create spans
with tracer.start_as_current_span("operation") as span:
    span.set_attribute("key", "value")
    with tracer.start_as_current_span("sub-operation") as child:
        child.add_event("event")
```

## 31. Alerting and SLOs

### SLI, SLO, and SLA

```yaml
# Service Level Indicator (SLI)
# - Request success rate
# - Request latency
# - Availability

# Service Level Objective (SLO)
# - 99.9% success rate over 30 days
# - P99 latency < 200ms

# Service Level Agreement (SLA)
# - Contract with customer
# - Usually stricter than SLO
# - Defines penalties for breach
```

```promql
# SLI: Request success rate
sum(rate(http_requests_total{job="myapp",status=~"2.."}[5m]))
/
sum(rate(http_requests_total{job="myapp"}[5m]))

# SLI: Latency (P99)
histogram_quantile(0.99, 
    sum(rate(http_request_duration_seconds_bucket{job="myapp"}[5m])) by (le)
)

# Error budget
# 30 days * 24 hours * 60 minutes = 43200 minutes
# 0.1% error budget = 43.2 minutes allowed downtime
# SLO: 99.9% over 30 days
```

---

## Part VII: Infrastructure as Code

## 32. Terraform

### Provider Architecture

```hcl
# provider "aws" {
#   region = "us-east-1"
# }

# Provider configuration
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  
  default_tags {
    tags = {
      Environment = "production"
      ManagedBy   = "terraform"
    }
  }
  
  alias = "west"
  region = "us-west-2"
}

# Use provider
resource "aws_instance" "example" {
  provider = aws.west
  ami      = "ami-12345678"
  # ...
}
```

### State Management

```bash
# Local state (default)
terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}

# Remote state (S3)
terraform {
  backend "s3" {
    bucket         = "my-terraform-state"
    key            = "prod/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-locks"
  }
}

# State commands
terraform state list
terraform state show aws_instance.example
terraform state mv aws_instance.old aws_instance.new
terraform state rm aws_instance.example
terraform state pull > backup.tfstate
```

### Modules and Expressions

```hcl
# Module usage
module "vpc" {
  source  = "./modules/vpc"
  
  cidr           = "10.0.0.0/16"
  environment    = "production"
  availability_zones = ["us-east-1a", "us-east-1b"]
  
  tags = {
    Project = "myapp"
  }
}

# For expressions
locals {
  instances = {
    for instance in aws_instance.example :
    instance.id => instance
  }
  
  # Filter
  production_instances = {
    for k, v in aws_instance.example :
    k => v if v.environment == "prod"
  }
  
  # Transform
  instance_names = [for instance in aws_instance.example : instance.id]
}

# Dynamic blocks
dynamic "ingress" {
  for_each = var.allowed_ports
  content {
    from_port   = ingress.value
    to_port     = ingress.value
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
```

## 33. Ansible

### Ansible Execution Model

```bash
# Ansible inventory
# /etc/ansible/hosts or inventory file
[webservers]
web01.example.com
web02.example.com

[webservers:vars]
ansible_user=admin
ansible_python_interpreter=/usr/bin/python3

[dbservers]
db01.example.com

[all:vars]
ansible_connection=ssh
ansible_private_key_file=~/.ssh/id_rsa
```

```bash
# Ad-hoc commands
ansible all -m ping
ansible webserver -m shell -a "uptime"
ansible webserver -m copy -a "src=file dest=/tmp/file"
ansible webserver -m systemd -a "name=nginx state=restarted"

# Playbooks
ansible-playbook site.yml

# Check mode (dry run)
ansible-playbook site.yml --check

# Diff mode
ansible-playbook site.yml --diff

# Tags
ansible-playbook site.yml --tags "web,db"
ansible-playbook site.yml --skip-tags "backup"
```

### Roles and Playbook Structure

```yaml
# site.yml
- name: Configure web servers
  hosts: webservers
  become: yes
  roles:
    - common
    - nginx
    - app

# Role structure
roles/
├── common/
│   ├── tasks/
│   │   └── main.yml
│   ├── handlers/
│   │   └── main.yml
│   ├── templates/
│   ├── files/
│   ├── vars/
│   │   └── main.yml
│   ├── defaults/
│   │   └── main.yml
│   └── meta/
│       └── main.yml
├── nginx/
└── app/
```

```yaml
# roles/common/tasks/main.yml
---
- name: Update apt cache
  apt:
    update_cache: yes
  when: ansible_os_family == "Debian"

- name: Install common packages
  package:
    name:
      - curl
      - vim
      - git
    state: present

- name: Setup NTP
  template:
    src: ntp.conf.j2
    dest: /etc/ntp.conf
  notify: Restart NTP
```

---

## Part VIII: CI/CD

## 34. Pipeline Architecture

### GitHub Actions

```yaml
name: CI/CD Pipeline

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

env:
  REGISTRY: ghcr.io
  IMAGE_NAME: ${{ github.repository }}

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v3
      
      - name: Login to Container Registry
        uses: docker/login-action@v3
        with:
          registry: ${{ env.REGISTRY }}
          username: ${{ github.actor }}
          password: ${{ secrets.GITHUB_TOKEN }}
      
      - name: Build and push
        uses: docker/build-push-action@v5
        with:
          context: .
          push: ${{ github.event_name != 'pull_request' }}
          tags: ${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}:${{ github.sha }}
          cache-from: type=gha
          cache-to: type=gha,mode=max
  
  test:
    needs: build
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Run tests
        run: |
          npm ci
          npm test
        env:
          DATABASE_URL: postgres://test:test@localhost:5432/test
      
      - name: Upload coverage
        uses: codecov/codecov-action@v3

  deploy:
    needs: test
    if: github.ref == 'refs/heads/main'
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Deploy to production
        run: |
          kubectl set image deployment/app app=${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}:${{ github.sha }}
```

## 35. GitOps

### ArgoCD

```bash
# Install ArgoCD
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Get password
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d

# Port forward
kubectl port-forward svc/argocd-server 8080:443

# CLI
argocd login argocd.example.com
argocd app create myapp \
  --repo https://github.com/org/repo.git \
  --path k8s \
  --dest-server https://kubernetes.default.svc \
  --dest-namespace production

# Sync
argocd app sync myapp
argocd app sync --prune myapp
```

---

## Part IX: Reliability Engineering

## 36. Caching

### Redis and Memcached

```bash
# Redis configuration
# /etc/redis/redis.conf
bind 127.0.0.1
port 6379
maxmemory 2gb
maxmemory-policy allkeys-lru
appendonly yes
save 900 1
save 300 10
save 60 10000

# Sentinel (HA)
sentinel monitor mymaster 127.0.0.1 6379 2
sentinel down-after-milliseconds mymaster 5000
sentinel failover-timeout mymaster 60000

# Cluster mode
redis-cli --cluster create 10.0.0.1:6379 10.0.0.2:6379 10.0.0.3:6379 \
  --cluster-replicas 1
```

```python
import redis

# Connection
r = redis.Redis(host='localhost', port=6379, db=0, decode_responses=True)

# Basic operations
r.set('key', 'value')
r.get('key')
r.delete('key')

# Expire
r.setex('key', 3600, 'value')  # 1 hour
r.expire('key', 3600)

# Hashes
r.hset('user:1', 'name', 'John')
r.hget('user:1', 'name')
r.hgetall('user:1')

# Lists
r.lpush('queue', 'item')
r.rpop('queue')

# Sets
r.sadd('tags', 'python', 'redis')
r.smembers('tags')

# Sorted sets (leaderboards)
r.zadd('scores', {'player1': 100, 'player2': 200})
r.zrevrange('scores', 0, 10, withscores=True)
```

## 37. Messaging and Queues

### Kafka: Partitions and Replication

```bash
# Create topic
kafka-topics.sh --create \
  --topic my-topic \
  --partitions 3 \
  --replication-factor 3 \
  --bootstrap-server localhost:9092

# Topic config
kafka-configs.sh --alter \
  --topic my-topic \
  --add-config retention.ms=86400000 \
  --bootstrap-server localhost:9092

# Consumer group
kafka-consumer-groups.sh \
  --bootstrap-server localhost:9092 \
  --group my-group \
  --describe

# Reset offsets
kafka-consumer-groups.sh \
  --bootstrap-server localhost:9092 \
  --group my-group \
  --reset-offsets --to-earliest \
  --topic my-topic --execute
```

```python
from kafka import KafkaProducer, KafkaConsumer

# Producer
producer = KafkaProducer(
    bootstrap_servers=['localhost:9092'],
    value_serializer=lambda v: json.dumps(v).encode('utf-8')
)

producer.send('my-topic', {'key': 'value'})
producer.flush()

# Consumer
consumer = KafkaConsumer(
    'my-topic',
    bootstrap_servers=['localhost:9092'],
    group_id='my-group',
    auto_offset_reset='earliest',
    enable_auto_commit=True
)

for message in consumer:
    print(f"{message.topic}:{message.partition}:{message.offset}: {message.value}")
```

## 38. Database Operations

### Replication Strategies

```bash
# PostgreSQL streaming replication
# Primary (postgresql.conf)
wal_level = replica
max_wal_senders = 3
max_replication_slots = 3
hot_standby = on

# pg_hba.conf (on primary)
host replication repl_user 10.0.0.0/24 md5

# Create replication user
CREATE USER repl_user WITH REPLICATION PASSWORD 'password';

# Backup for replica
pg_basebackup -h primary -D /var/lib/postgresql/14/main -P -Xs -R

# Standby (postgresql.conf on replica)
hot_standby = on
primary_conninfo = 'host=primary port=5432 user=repl_user'
```

### Connection Pooling

```bash
# PgBouncer configuration
# /etc/pgbouncer/pgbouncer.ini
[databases]
mydb = host=localhost dbname=mydb

[pgbouncer]
listen_addr = 127.0.0.1
listen_port = 6432
auth_type = md5
auth_file = /etc/pgbouncer/userlist.txt
pool_mode = transaction
max_client_conn = 1000
default_pool_size = 25

# userlist.txt (format: "user" "password")
"user" "md5hash"
```

---

## 39. API Gateways

### Kong and NGINX Gateway

```yaml
# Kong declarative configuration
_format_version: "3.0"
services:
  - name: my-api
    url: http://backend:8080
    routes:
      - name: my-route
        paths:
          - /api
        methods:
          - GET
          - POST
    plugins:
      - name: rate-limiting
        config:
          minute: 100
          policy: local
      - name: jwt
      - name: cors
```

### Rate Limiting and Auth

```yaml
# NGINX rate limiting
http {
    limit_req_zone $binary_remote_addr zone=api:10m rate=10r/s;
    
    server {
        location /api/ {
            limit_req zone=api burst=20 nodelay;
            
            # JWT validation
            auth_jwt "API" token=$cookie_token;
            auth_jwt_key_file /etc/nginx/jwt.json;
        }
    }
}
```

### Circuit Breaking

```yaml
# Kong circuit breaker
services:
  - name: my-api
    url: http://backend:8080
    plugins:
      - name: circuit-breaker
        config:
          break_response_code: 503
          timeout: 6
          heartbeat: 5
          detection_timeout: 30
          half_open_requests: 3
```

---

## 40. Chaos Engineering

### Chaos Engineering Principles

```markdown
# Game Day Checklist
1. Define steady state hypothesis
2. Inject failure
3. Observe system behavior
4. Document findings
5. Implement fixes
```

### Chaos Mesh and Litmus

```bash
# Install Chaos Mesh
helm repo add chaos-mesh https://charts.chaos-mesh.org
helm install chaos-mesh chaos-mesh/chaos-mesh -n chaos-mesh --create-namespace

# Create PodChaos experiment
apiVersion: chaos-mesh.org/v1alpha1
kind: PodChaos
metadata:
  name: pod-kill
spec:
  action: pod-kill
  mode: one
  duration: "10s"
  selector:
    labelSelectors:
      app: api
```

### Game Days

```bash
# Game day script
#!/bin/bash
set -e

echo "Starting game day: $(date)"

# 1. Verify baseline
kubectl top nodes
kubectl get pods -A

# 2. Simulate network partition
kubectl label nodes node1 network Partition=true

# 3. Inject latency
kubectl apply -f latency-injection.yaml

# 4. Kill random pods
for i in {1..5}; do
    kubectl delete pod -l app=api --force --grace-period=0
    sleep 10
done

# 5. Document results
echo "Game day complete"
```

---

## 41. Service Mesh

### Istio Basics

```yaml
# VirtualService
apiVersion: networking.istio.io/v1beta1
kind: VirtualService
metadata:
  name: my-service
spec:
  hosts:
  - my-service
  http:
  - match:
    - headers:
        x-canary:
          exact: "true"
    route:
    - destination:
        host: my-service
        subset: v2
      weight: 100
  - route:
    - destination:
        host: my-service
        subset: v1
      weight: 100
```

```yaml
# DestinationRule
apiVersion: networking.istio.io/v1beta1
kind: DestinationRule
metadata:
  name: my-service
spec:
  host: my-service
  trafficPolicy:
    connectionPool:
      tcp:
        maxConnections: 100
      http:
        h2UpgradePolicy: UPGRADE
        http2MaxRequests: 1000
    loadBalancer:
      simple: LEAST_CONN
    outlierDetection:
      consecutive5xxErrors: 5
      interval: 30s
      baseEjectionTime: 30s
```

### Linkerd

```bash
# Install Linkerd
linkerd install | kubectl apply -f -
linkerd viz install | kubectl apply -f -

# Check service mesh status
linkerd check
linkerd viz dashboard &

# Add to pod
kubectl get deploy -o yaml | linkerd inject - | kubectl apply -f -
```

---

## Part X: Incident Management and Access

## 42. Access and Bastion Hosts

### SSH Key Management

```bash
# Generate key
ssh-keygen -t ed25519 -C "user@host"

# Add to agent
ssh-add ~/.ssh/id_ed25519

# Copy to server
ssh-copy-id user@server

# Restrict key (command restriction)
command="docker ps" ssh-ed25519 AAAA... user@host

# SSH certificate authority
# 1. Create CA
ssh-keygen -t ed25519 -f ca_key

# 2. Sign user key
ssh-keygen -s ca_key -I "user@production" -n username -V +52w user_key.pub

# 3. Trust CA
echo "@cert-authority *.example.com ssh-ed25519 AAAABBBB..." >> ~/.ssh/known_hosts
```

### Bastion Host Patterns

```bash
# AWS Session Manager (no bastion needed)
# Install session manager plugin
# ssm-instance document

# Configure SSH through SSM
# ~/.ssh/config
Host i-*
    ProxyCommand sh -c "aws ssm start-session --target %h --document-name AWS-StartSSHSession --parameters 'portNumber=%p'"

# Tunnel through bastion
ssh -J bastion.example.com user@internal.example.com
```

## 43. Incident Management

### Post-Mortems

```markdown
# Incident Post-Mortem: Service Outage

## Summary
- **Date**: 2024-01-15
- **Duration**: 2 hours
- **Impact**: 5000 users affected, 30% error rate
- **Root Cause**: Database connection pool exhaustion

## Timeline
- 10:00 - Deployment of new feature
- 10:15 - Alerts fire: high error rate
- 10:20 - Incident declared SEV-1
- 10:45 - Root cause identified
- 11:30 - Fix deployed
- 12:00 - Incident resolved

## Root Cause
New feature added without connection pool limit, 
causing connection leak under load.

## Action Items
- [ ] Add connection pool limits (TODO: 2024-01-20)
- [ ] Add connection leak detection (TODO: 2024-01-25)
- [ ] Review deployment process for resource limits
```

### Severity Classification

| SEV | Description | Response Time | Examples |
|-----|-------------|---------------|----------|
| SEV1 | Critical - Complete outage | 15 min | All users affected, no workaround |
| SEV2 | Major - Significant impact | 30 min | Feature unavailable, workaround exists |
| SEV3 | Minor - Minor impact | 2 hours | Degraded performance, minor feature broken |
| SEV4 | Low - Minimal impact | 24 hours | Cosmetic issue, documentation error |

## 44. Disaster Recovery

### RTO and RPO

```bash
# Recovery Time Objective (RTO)
# Maximum acceptable time to restore service
# Example: 4 hours

# Recovery Point Objective (RPO)
# Maximum acceptable data loss (time)
# Example: 1 hour (backup every hour)
```

### Backup Strategies

```bash
# Database backup (PostgreSQL)
#!/bin/bash
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="/backup/postgres"
DATABASE="mydb"

# Full backup
pg_dump -Fc -f "$BACKUP_DIR/full_$DATE.dump" $DATABASE

# Incremental (WAL archiving)
# Configure wal_level = replica in postgresql.conf
# Archive command:
# archive_command = 'cp %p /backup/wal/%f'

# Point-in-time recovery
# Stop PostgreSQL
# Recover to specific time
# pg_restore -d mydb --target-time="2024-01-15 10:00:00" backup.dump

# Filesystem backup (rsync)
rsync -avz --delete /data /backup/data

# Retention
find /backup -type f -mtime +30 -delete
```
