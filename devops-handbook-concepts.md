# DevOps Handbook

## Table of Contents

### Part I: Linux Fundamentals

#### 1. Understanding the Linux Kernel
* [What is the Kernel](#what-is-the-kernel)
* [Kernel Architecture](#kernel-architecture)
* [System Calls](#system-calls)
* [Kernel Modules](#kernel-modules)
* [Kernel Versions and Distributions](#kernel-versions-and-distributions)

#### 2. Files and Filesystems
* [What is a File](#what-is-a-file)
* [The Virtual File System (VFS)](#the-virtual-file-system-vfs)
* [Filesystem Types and Their Characteristics](#filesystem-types-and-their-characteristics)
* [Inodes and Directory Entries](#inodes-and-directory-entries)
* [File Permissions and Special Modes](#file-permissions-and-special-modes)
* [Hard Links and Symbolic Links](#hard-links-and-symbolic-links)

#### 3. Users, Groups, and Permissions
* [User Identification in Linux](#user-identification-in-linux)
* [Group Membership and GID](#group-membership-and-gid)
* [The Shadow Password File](#the-shadow-password-file)
* [sudo and Privilege Escalation](#sudo-and-privilege-escalation)
* [PAM (Pluggable Authentication Modules)](#pam-pluggable-authentication-modules)

#### 4. Process Management
* [What is a Process](#what-is-a-process)
* [Process States and Lifecycle](#process-states-and-lifecycle)
* [The Process Table](#the-process-table)
* [Fork and Exec](#fork-and-exec)
* [Signals and Signal Handling](#signals-and-signal-handling)
* [Process Scheduling](#process-scheduling)

#### 5. Memory Management
* [Virtual Memory Concepts](#virtual-memory-concepts)
* [Physical vs Virtual Addresses](#physical-vs-virtual-addresses)
* [Paging and Page Tables](#paging-and-page-tables)
* [Swap Space and Swapping](#swap-space-and-swapping)
* [The OOM Killer](#the-oom-killer)
* [Memory Cgroups](#memory-cgroups)

#### 6. Boot Process and Bootloaders
* [The Boot Sequence](#the-boot-sequence)
* [BIOS and UEFI](#bios-and-uefi)
* [Bootloaders: GRUB and systemd-boot](#bootloaders-grub-and-systemd-boot)
* [Kernel Initialization](#kernel-initialization)
* [Init and the First Process](#init-and-the-first-process)

#### 7. Systemd and Service Management
* [What is Systemd](#what-is-systemd)
* [Unit Files and Unit Types](#unit-files-and-unit-types)
* [Service Units Deep Dive](#service-units-deep-dive)
* [Targets and Boot Levels](#targets-and-boot-levels)
* [Socket Activation](#socket-activation)
* [Timers vs Cron](#timers-vs-cron)
* [Cgroups and Resource Control](#cgroups-and-resource-control)
* [Systemd Journal](#systemd-journal)

#### 8. Networking Fundamentals
* [The Network Stack](#the-network-stack)
* [TCP/IP Model](#tcpip-model)
* [IP Addresses and Subnets](#ip-addresses-and-subnets)
* [Ports and Sockets](#ports-and-sockets)
* [DNS Resolution](#dns-resolution)
* [Network Namespaces](#network-namespaces)

#### 9. Iptables and Firewalls
* [What is a Firewall](#what-is-a-firewall)
* [iptables Tables and Chains](#iptables-tables-and-chains)
* [How Packet Filtering Works](#how-packet-filtering-works)
* [NAT and Masquerading](#nat-and-masquerading)
* [nftables: The Modern Replacement](#nftables-the-modern-replacement)

#### 10. Disk Partitioning and LVM
* [Disk Geometry and Partitions](#disk-geometry-and-partitions)
* [MBR vs GPT](#mbr-vs-gpt)
* [What is LVM](#what-is-lvm)
* [Physical Volumes, Volume Groups, and Logical Volumes](#physical-volumes-volume-groups-and-logical-volumes)
* [RAID Concepts](#raid-concepts)

#### 11. System Logging
* [Syslog Architecture](#syslog-architecture)
* [The systemd Journal](#the-systemd-journal)
* [Log Rotation](#log-rotation)
* [Centralized Logging](#centralized-logging)

### Part II: Networking

#### 12. TCP and UDP Deep Dive
* [TCP vs UDP](#tcp-vs-udp)
* [TCP Three-Way Handshake](#tcp-three-way-handshake)
* [TCP State Machine](#tcp-state-machine)
* [Flow Control and Windowing](#flow-control-and-windowing)
* [Congestion Control Algorithms](#congestion-control-algorithms)

#### 13. HTTP and Web Protocols
* [HTTP/1.1 Internals](#http11-internals)
* [HTTP/2 Improvements](#http2-improvements)
* [HTTP/3 and QUIC](#http3-and-quic)
* [TLS Handshake](#tls-handshake)

#### 14. Load Balancing Theory
* [Load Balancing Concepts](#load-balancing-concepts)
* [Algorithms and Strategies](#algorithms-and-strateges)
* [Health Checks](#health-checks)
* [Layer 4 vs Layer 7 Balancing](#layer-4-vs-layer-7-balancing)

### Part III: Cryptography

#### 15. Cryptographic Fundamentals
* [Symmetric Encryption](#symmetric-encryption)
* [Asymmetric Encryption](#asymmetric-encryption)
* [Hashing and Message Digests](#hashing-and-message-digests)
* [Digital Signatures](#digital-signatures)

#### 16. PKI and Certificates
* [What is PKI](#what-is-pki)
* [X.509 Certificates](#x509-certificates)
* [Certificate Chains and Trust](#certificate-chains-and-trust)
* [Certificate Authorities](#certificate-authorities)

### Part IV: Containers

#### 17. Container Technology
* [What are Containers](#what-are-containers)
* [Namespaces for Isolation](#namespaces-for-isolation)
* [Control Groups (cgroups)](#control-groups-cgroups)
* [Container Images and Layers](#container-images-and-layers)
* [Container Registries](#container-registries)

#### 18. Docker Architecture
* [Docker Daemon and Client](#docker-daemon-and-client)
* [containerd and OCI](#containerd-and-oci)
* [Storage Drivers](#storage-drivers)
* [Networking Drivers](#networking-drivers)

#### 19. Kubernetes Architecture
* [Kubernetes Components](#kubernetes-components)
* [The API Server](#the-api-server)
* [etcd: The datastore](#etcd-the-datastore)
* [Controllers and Reconciliation](#controllers-and-reconciliation)
* [Scheduler](#scheduler)

### Part V: Observability

#### 20. Metrics and Monitoring
* [What to Monitor](#what-to-monitor)
* [Push vs Pull Metrics](#push-vs-pull-metrics)
* [Prometheus Model](#prometheus-model)
* [Metric Types: Gauges, Counters, Histograms](#metric-types-gauges-counters-histograms)

#### 21. Logging and Log Analysis
* [Log Management Challenges](#log-management-challenges)
* [Structured Logging](#structured-logging)
* [Log Aggregation](#log-aggregation)
* [Indexing and Search](#indexing-and-search)

#### 22. Distributed Tracing
* [The Need for Tracing](#the-need-for-tracing)
* [Traces and Spans](#traces-and-spans)
* [Context Propagation](#context-propagation)
* [OpenTelemetry](#opentelemetry)

### Part VI: Infrastructure as Code

#### 23. Terraform and IaC
* [What is Infrastructure as Code](#what-is-infrastructure-as-code)
* [Declarative vs Imperative](#declarative-vs-imperative)
* [Terraform State](#terraform-state)
* [Providers and Resources](#providers-and-resources)

#### 24. Configuration Management
* [Ansible Concepts](#ansible-concepts)
* [Idempotency](#idempotency)
* [Pull vs Push Models](#pull-vs-push-models)

### Part VII: CI/CD

#### 25. Pipeline Architecture
* [Pipeline Stages](#pipeline-stages)
* [Build Strategies](#build-strategies)
* [Artifact Management](#artifact-management)
* [GitOps Principles](#gitops-principles)

### Part VIII: Reliability

#### 26. Caching
* [Caching Principles](#caching-principles)
* [Cache Invalidation](#cache-invalidation)
* [Redis and Memcached](#redis-and-memcached)

#### 27. Message Queues
* [Why Message Queues](#why-message-queues)
* [Publish/Subscribe](#publishsubscribe)
* [Message Ordering and Delivery](#message-ordering-and-delivery)

#### 28. Database Operations
* [Replication Strategies](#replication-strategies)
* [Connection Pooling](#connection-pooling)
* [Backup Strategies](#backup-strategies)

#### 29. API Gateways
* [API Gateway Patterns](#api-gateway-patterns)
* [Rate Limiting](#rate-limiting)
* [Circuit Breakers](#circuit-breakers)

### Part IX: Incident Management

#### 30. On-Call and Incident Response
* [Building an Incident Response Process](#building-an-incident-response-process)
* [Runbooks and Automation](#runbooks-and-automation)
* [Post-Mortems](#post-mortems)

#### 31. Disaster Recovery
* [RTO and RPO](#rto-and-rpo)
* [Backup Strategies](#backup-strategies-1)
* [Testing Recovery Procedures](#testing-recovery-procedures)

---

## Part I: Linux Fundamentals

## 1. Understanding the Linux Kernel

### What is the Kernel

The Linux kernel is the heart of the Linux operating system, a piece of software that acts as the bridge between applications and the computer hardware. When you run any program—whether it's a simple command like `ls` or a complex web server—the kernel orchestrates every operation, deciding how to allocate resources, how to interact with hardware, and how to keep multiple programs running smoothly without interfering with each other.

To understand the kernel's role, imagine a large office building with a single receptionist. Every visitor (application) must go through the receptionist (kernel) to access the offices (hardware). The receptionist handles security, directs traffic, allocates meeting rooms (memory), and ensures everything runs efficiently. Without the receptionist, visitors would wander aimlessly, fight over resources, and the building would descend into chaos. The kernel plays this crucial coordinating role in a computer system.

The kernel operates in a privileged mode called "kernel space" or "supervisor mode," which gives it access to all memory and hardware capabilities. User applications run in "user space," where they have limited permissions and must request kernel assistance for any privileged operations. This separation is fundamental to Unix-like operating systems and provides security and stability—bugs in user applications typically crash only that application, not the entire system.

The Linux kernel has been under continuous development since its creation in 1991 by Linus Torvalds. Today, it powers everything from Android phones to supercomputers, from embedded devices to cloud infrastructure. Its versatility comes from a modular design that allows drivers, filesystems, and other components to be loaded or unloaded as needed, making it adaptable to virtually any use case.

### Kernel Architecture

The Linux kernel architecture is a layered design that evolved from traditional Unix monolithic kernels while incorporating ideas from microkernel architectures. Understanding this architecture helps explain how Linux achieves both performance and flexibility.

At the lowest level sits the **hardware abstraction layer**, which includes device drivers that interact directly with specific hardware components. These drivers translate generic kernel requests into hardware-specific operations—whether controlling a network card, reading from a disk, or managing a graphics adapter. The kernel supports thousands of drivers, both built into the kernel itself and loaded as separate modules.

Above the hardware layer sits the **system call interface**, which is the boundary between user space and kernel space. Every operation that requires privileged access—reading a file, creating a process, allocating memory, opening a network connection—goes through this interface. The system calls provide a stable API that applications can rely on, regardless of how the kernel is implemented internally.

The core kernel subsystems handle fundamental operations:

The **process scheduler** decides which processes get CPU time and on which cores. Linux supports preemptive multitasking, meaning it can interrupt a running process to give CPU time to others. This creates the illusion that multiple programs run simultaneously, even on a single CPU core.

**Memory management** handles allocating RAM to processes, swapping data to disk when needed, and ensuring processes can't access each other's memory. This virtual memory system is what allows each process to have its own address space, providing isolation and security.

The **virtual filesystem (VFS)** layer provides a common interface for different filesystem types. Whether you're reading from an ext4 disk, an NFS network share, or a tmpfs in-memory filesystem, the VFS presents a unified API. This abstraction is why you can mount different filesystem types in Linux without applications needing to know the details.

**Networking** implements the TCP/IP stack and related protocols, handling packet routing, connection management, and network interfaces. This subsystem is remarkably sophisticated, supporting everything from basic Ethernet to complex virtual networks for containers.

```c
// Example: System calls are the interface between user space and kernel
// When you call write(fd, buffer, size), this translates to:
// 1. User mode: execute write() from libc
// 2. libc: execute syscall instruction with syscall number (e.g., 1 for write)
// 3. Kernel mode: sys_write() function handles the actual operation
// 4. Returns to user space with result

// The syscall number for write is 1 on x86_64
// For read, it's 0
```

### System Calls

System calls (syscalls) are the fundamental interface between user applications and the kernel. They represent the only way user programs can access privileged operations, and understanding them illuminates how the entire operating system functions.

When a program needs to read a file, create a network connection, allocate memory, or perform any operation requiring kernel assistance, it makes a system call. This involves a specific CPU instruction (like `syscall` on x86_64) that switches the processor from user mode to kernel mode, transfers control to the appropriate kernel function, and returns results to user space.

Linux provides hundreds of system calls, each identified by a number. Some of the most commonly used include:

**File Operations**: `open()`, `read()`, `write()`, `close()`, `lseek()`, `stat()` allow programs to work with files. These operations aren't just for disk files—they also work with devices, pipes, sockets, and other special files.

**Process Management**: `fork()` creates a new process by duplicating the calling process. `exec()` replaces the current process's program with a new one. `wait()` allows a parent process to wait for child completion. `exit()` terminates a process. `getpid()` returns the process ID.

**Memory Management**: `mmap()` maps files or devices into memory. `brk()` adjusts the process's data segment size. These are the primitives that higher-level memory allocation (like `malloc()`) build upon.

**Inter-Process Communication**: `pipe()` creates a pipe for data flow between related processes. `msgget()`, `semget()`, `shmget()` provide System V IPC primitives. `socket()` creates network sockets.

**Security and Credentials**: `getuid()`, `setuid()` manage user IDs. `chmod()`, `chown()` change file permissions. These are the foundation of Linux's security model.

You can observe system calls in action using tools like `strace`, which traces all system calls made by a program:

```bash
# strace shows every system call a program makes
# This shows just a few lines of 'ls' making syscalls:
strace ls /tmp 2>&1 | head -20

# Output might show:
# execve("/bin/ls", ["ls", "/tmp"], 0x7ffc...)= 0
# brk(NULL)= 0x562...
# access("/etc/ld.so.preload", R_OK)= -1 ENOENT
# openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC)= 3
# openat(AT_FDCWD, "/lib64/libc.so.6", O_RDONLY|O_CLOEXEC)= 3
```

Each line shows the system call name, its arguments, and its return value. This visibility makes strace invaluable for debugging and understanding program behavior.

### Kernel Modules

One of Linux's most powerful features is its ability to load and unload code at runtime through **kernel modules** (also known as Loadable Kernel Modules or LKMs). This modularity allows the kernel to be extended without recompilation or reboot, and drivers can be loaded only when needed.

Kernel modules live in `/lib/modules/` organized by kernel version. When you load a module with `modprobe` or `insmod`, the kernel:
1. Allocates memory for the module
2. Resolves symbols (functions and variables the module needs from the kernel)
3. Calls the module's initialization function
4. Adds the module to the kernel's internal structures

Modules can be unloaded with `rmmod` or `modprobe -r`, freeing the memory and calling the module's cleanup function. This is the mechanism that allows you to add hardware support, load filesystem drivers, or add system call functionality without rebooting.

Common module operations:

```bash
# List currently loaded modules
lsmod

# Load a module
modprobe nf_conntrack

# Load with parameters
modprobe nf_conntrack ip_conntrack_max=65536

# Remove a module
modprobe -r nf_conntrack

# Get module information
modinfo nf_conntrack
```

Modules often have dependencies—loading one module might automatically load others. For example, the `nfs` filesystem module depends on network and RPC modules. The module dependency system tracks these relationships.

### Kernel Versions and Distributions

Linux kernel versions follow a specific numbering scheme that communicates the nature and stability of each release. Understanding this helps when choosing kernels for different purposes.

The version string format is `major.minor.patch`, where:

The **major version** increments when major architectural changes occur or when there's a significant shift in development philosophy. For example, version 2.x was the "enterprise" kernel series, while version 3.x marked a shift to faster development with more frequent releases.

The **minor version** indicates new features. Historically, odd minor versions (like 2.5.x, 3.x) were development releases receiving new features rapidly but potentially less stable. Even minor versions (like 2.6.x, 4.x) were stable releases. This convention has become less strict in recent years.

The **patch level** increments for bug fixes and security patches within a release series.

**Longterm (LTS) kernels** receive maintenance updates for years—typically 2-6 years. These are what most production servers run. For example, kernel 5.15 was an LTS release that received security patches for several years.

Different Linux distributions ship different kernel versions:

**Enterprise distributions** (RHEL, SLES, Ubuntu LTS) prioritize stability and long-term support. They often backport features and fixes from newer kernels while maintaining API/ABI compatibility. RHEL 9 might run kernel 5.14, but with features and fixes from later kernels.

**Rolling releases** (Arch Linux, openSUSE Tumbleweed) ship with the latest kernel, prioritizing cutting-edge features over stability. These are good for workstations and development but require careful testing for production.

The kernel is configurable through thousands of compile-time options, enabling everything from tiny embedded systems to massive supercomputers. Distributions ship pre-built kernels optimized for common use cases, but you can compile custom kernels for specific requirements.

---

## 2. Files and Filesystems

### What is a File

The Unix philosophy of "everything is a file" is one of the most elegant and powerful concepts in operating system design. In Linux, not only are regular files (documents, images, programs) treated as files, but also directories, devices, pipes, sockets, and even running processes have a file-like interface. This uniform treatment simplifies software development—you can read from a disk, a network connection, or a device using the same system calls.

A **file** in Linux is fundamentally a sequence of bytes stored on a storage device, identified by a name within a directory. The operating system doesn't impose any particular structure on the bytes—it's entirely up to the application to interpret them. A text file's bytes represent characters; an image file's bytes represent pixel colors; an executable's bytes represent machine instructions.

This byte-oriented view provides incredible flexibility. The same operations (`open`, `read`, `write`, `close`) work regardless of what's behind the file—whether it's a physical hard drive, a network connection, or a device. This is why you can redirect command output to a file or a network socket using identical syntax.

Files have associated **metadata**—information about the file itself rather than its contents. This includes:
- The file's size in bytes
- Timestamps: when it was last accessed, modified, and when its metadata changed
- The file's type (regular file, directory, device, etc.)
- The file's permissions
- The file's owner (UID) and group (GID)
- How many hard links point to it

This metadata is stored in a data structure called an **inode**, which we'll explore later in this chapter.

### The Virtual File System (VFS)

The Virtual File System (VFS), also called the Virtual Filesystem Switch, is a kernel subsystem that provides a common interface for all filesystem operations. It's the glue that allows Linux to support dozens of different filesystem types simultaneously, from native Linux filesystems to network filesystems to special in-memory filesystems.

When an application performs a filesystem operation—opening a file, reading from it, listing a directory—the VFS layer receives the request first. The VFS determines which actual filesystem contains the target and calls the appropriate filesystem-specific functions. This abstraction means:

- Applications don't need to know whether a file is on an ext4 disk, an NFS share, or a CIFS Windows share
- New filesystem types can be added by implementing the VFS interface without changing applications
- The kernel can "mount" different filesystems at arbitrary points in the directory tree

The VFS defines a standard set of operations (the `file_operations`, `inode_operations`, and `super_operations` structures in kernel code) that each filesystem must implement. For example, the `read` operation in VFS calls the filesystem-specific function that knows how to read from that particular storage type.

This is remarkably powerful. Consider what happens when you read from `/home/user/file.txt` where `/home` might be an NFS mount and `/tmp` might be a tmpfs in-memory filesystem:

```c
// Simplified conceptual view of VFS in action:
// 
// User code: read(fd, buffer, 1024)
// 
// VFS layer receives this and:
// 1. Gets the file's inode
// 2. Determines which superblock (filesystem) it's from
// 3. Calls the superblock's read function:
//    - For ext4: reads from disk blocks
//    - For NFS: sends network request to NFS server  
//    - For tmpfs: copies from memory
// 4. Returns data to user space
```

Linux supports numerous filesystem types:

**Disk-based filesystems**: ext2, ext3, ext4, XFS, Btrfs, F2FS—are designed for physical storage devices. ext4 (Fourth Extended Filesystem) is the most common, known for reliability and performance. XFS excels with large files and high I/O throughput. Btrfs offers modern features like snapshots and built-in RAID.

**Network filesystems**: NFS (Network File System), CIFS/SMB (Server Message Block)—allow accessing files on remote servers as if they were local.

**Special-purpose filesystems**: procfs (`/proc`) exposes kernel and process information. sysfs (`/sys`) provides a hierarchical view of devices and kernel objects. tmpfs stores files in RAM for extreme speed. devpts provides terminal devices.

### Filesystem Types and Their Characteristics

Choosing the right filesystem affects performance, reliability, and features. Let's examine the most common Linux filesystems and their trade-offs.

**ext4 (Fourth Extended Filesystem)** is the default choice for most Linux installations. It evolved from ext2 and ext3, adding features while maintaining backward compatibility. ext4 supports files up to 16TB and filesystems up to 1EB (although practical limits are lower). It uses **extents**—contiguous blocks of storage—which significantly improves performance for large files compared to the older block-mapping approach. ext4 includes journaling, which records metadata changes before applying them, preventing filesystem corruption after crashes. It's mature, well-tested, and performs excellently for most workloads.

**XFS** was originally created by SGI for their high-performance workstations and later became the default for RHEL/CentOS. XFS excels with large files and concurrent I/O operations, making it excellent for media production, scientific computing, and other I/O-intensive workloads. It handles filesystems up to 8EB and individual files up to 8EB. XFS has robust metadata journaling and handles unexpected shutdowns well. Its performance characteristics make it particularly good for workloads with many parallel threads accessing different files.

**Btrfs** (B-tree Filesystem) represents the next generation of Linux filesystems. It's a **copy-on-write** (COW) filesystem—when you modify a file, Btrfs writes the changes to new blocks rather than overwriting existing ones. This design provides several powerful features:

- **Snapshots**: Create point-in-time copies of the filesystem with virtually no overhead
- **Built-in RAID**: Native support for RAID 0, 1, 10, and 5/6 without separate RAID software
- **Data checksumming**: Automatic detection of data corruption
- **Subvolumes**: Independent filesystem views within a single Btrfs
- **Compression**: Transparent compression can reduce storage requirements

Btrfs is production-ready for many use cases but has had a turbulent history with stability concerns in certain configurations. It's an excellent choice for scenarios where its features (especially snapshots) provide significant benefits.

**tmpfs** (temporary filesystem) stores files in memory rather than on disk. Since memory is volatile, tmpfs contents disappear on reboot—but this also means zero disk I/O, making it ideal for /tmp, /run, and other temporary storage. Because tmpfs uses virtual memory, it can swap to disk if the system runs out of RAM.

### Inodes and Directory Entries

The inode is the fundamental data structure in Unix filesystems. Every file (and directory, device, pipe, etc.) has an inode that stores all its metadata. The inode doesn't store the filename—that's handled separately in directory entries.

An **inode** contains:
- **File type**: Regular file, directory, symbolic link, device, socket, pipe
- **Permissions**: The familiar rwx triples for owner, group, and others
- **Owner and group IDs**: UID and GID
- **File size**: In bytes for regular files
- **Timestamps**:
  - `atime`: Last access time (when the file was read)
  - `mtime`: Last modification time (when file content changed)
  - `ctime`: Last change time (when inode metadata changed)
  - `birth` (on some filesystems): When the file was created
- **Block pointers**: Addresses of disk blocks containing the file's data
- **Link count**: Number of hard links pointing to this inode
- **Extended attributes**: Additional key-value pairs (SELinux labels, capabilities, etc.)

The **directory entry** (sometimes called a "dentry") is what maps filenames to inodes. A directory is simply a special file containing a list of (inode number, filename) pairs. When you access `/home/user/file.txt`, the system:

1. Looks up `home` in the root directory to find home's inode
2. Looks up `user` in home's directory to find user's inode  
3. Looks up `file.txt` in user's directory to find the file's inode
4. Uses that inode to access the file's contents

This explains why hard links share inodes—they point to the same inode, so they appear as different names for the same file. It also explains why deleting a filename decrements the link count but doesn't necessarily delete the file—the file (inode) persists while any hard links remain.

You can view inode numbers with `ls -li`:

```
$ ls -li /etc/passwd
131073 -rw-r--r-- 1 root root 2343 Jan 15 10:30 /etc/passwd
```

The first column (131073) is the inode number.

### File Permissions and Special Modes

Linux file permissions follow a simple but powerful model based on three categories (owner, group, others) and three permission types (read, write, execute).

The permission string `-rw-r--r--` is interpreted as:
- First character: File type (`-` regular, `d` directory, `l` symbolic link, `c` character device, `b` block device, `s` socket, `p` named pipe)
- Characters 2-4: Owner permissions (rw-)
- Characters 5-7: Group permissions (r--)
- Characters 8-10: Others permissions (r--)

For directories, `r` means you can list contents, `w` means you can create/delete files within, and `x` means you can traverse (cd into) the directory.

**Numeric mode** provides a compact representation where each permission is a bitmask:

```bash
# Permission bits as numbers:
# r = 4, w = 2, x = 1
# 
# Common permissions:
# 644 = rw-r--r--  (owner can read/write, others read)
# 755 = rwxr-xr-x (owner can all, others execute)
# 600 = rw-------   (owner only)
# 777 = rwxrwxrwx  (everyone full access - dangerous!)

# Set permissions:
chmod 755 /some/path
chmod u=rw,go=r /some/path
```

**Special permission bits** extend the basic model:

The **SetUID bit** (shown as 's' in owner's execute position, numeric 4000) causes the program to run with the owner's permissions, regardless of who runs it. This is used for system programs like `passwd` (needs root access to write to /etc/shadow). It's a significant security risk if misused.

The **SetGID bit** (shown as 's' in group's execute position, numeric 2000) works similarly but for groups. On directories, new files inherit the directory's group rather than the creating user's group.

The **Sticky bit** (shown as 't' in others' execute position, numeric 1000) is particularly important for shared directories. Without it, any user with write permission can delete files they don't own—a major problem for `/tmp`. With the sticky bit set, users can only delete their own files.

```bash
# Set special permissions:
chmod 4755 /path/to/setuid-program    # SetUID
chmod 2755 /path/to/setgid-directory  # SetGID  
chmod 1777 /shared/tmp                # Sticky bit
```

### Hard Links and Symbolic Links

Linux provides two types of links: hard links and symbolic links (symlinks), each with different characteristics and use cases.

A **hard link** is an additional directory entry pointing to the same inode. Multiple hard links share the same file data—they're literally the same file with multiple names. The filesystem maintains a link count on the inode; the file is only deleted when the link count reaches zero.

```bash
# Create a hard link
ln original.txt hardlink.txt

# Both point to the same inode:
$ ls -li original.txt hardlink.txt
131073 -rw-r--r-- 2 user user 100 Jan 15 10:30 original.txt
131073 -rw-r--r-- 2 user user 100 Jan 15 10:30 hardlink.txt

# Note: link count is 2, and both have the same inode number
```

Hard links have constraints: they cannot span filesystems (inodes are per-filesystem), and they cannot link to directories (this prevents cycles in the directory tree that would break traversal algorithms).

A **symbolic link** is a special file containing a path to another file. The symlink "points to" its target; accessing the symlink transparently follows to the target.

```bash
# Create a symbolic link
ln -s /original/path symlink

# The symlink has its own inode:
$ ls -li original.txt symlink
131073 -rw-r--r-- 1 user user 100 Jan 15 10:30 original.txt
131080 lrwxrwxrwx 1 user user  11 Jan 15 10:31 symlink -> /original/path

# Note: different inode numbers; symlink is a special file type ('l')
```

Symbolic links can:
- Point to non-existent targets ("broken links")
- Span filesystems
- Link to directories

When you delete the original file, a hard link continues to work (the file data remains), but a symbolic link breaks (it points to nothing). Symlinks add a small performance cost for resolution; hard links are transparent.

---

## 3. Users, Groups, and Permissions

### User Identification in Linux

Linux is a multi-user operating system—it supports simultaneous users with separate identities, permissions, and resource limits. Every process runs as a specific user, and this identity determines what resources it can access.

The **User ID (UID)** is a numeric identifier for a user. Linux reserves UID 0 for root (the superuser with unrestricted access), and UIDs 1-99 for system use. Regular users typically have UIDs starting at 1000, though this varies by distribution.

User information is stored in `/etc/passwd` (world-readable for compatibility with old programs):

```
root:x:0:0:root:/root:/bin/bash
daemon:x:1:1:daemon:/usr/sbin:/usr/sbin/nologin
user:x:1000:1000:User Name:/home/user:/bin/bash
```

The fields are: username, password placeholder (usually 'x', real password elsewhere), UID, GID, GECOS (full name/info), home directory, login shell.

### Group Membership and GID

Groups provide a way to manage permissions for collections of users. Each user has a **primary group** (their default GID in /etc/passwd) and can belong to additional **supplementary groups**.

Group information lives in `/etc/group`:

```
root:x:0:
sudo:x:27:user1,user2
developers:x:1000:user1,user2,user3
```

When a process creates a file, the file normally belongs to the process's primary group. Supplementary group membership affects what resources the process can access—processes can access files belonging to any of their groups.

The `id` command shows your identity:

```
$ id
uid=1000(user) gid=1000(user) groups=1000(user),27(sudo),1001(developers)
```

### The Shadow Password File

Storing password hashes in `/etc/passwd` was a security vulnerability—anyone could read the file and crack the passwords. Modern Linux uses `/etc/shadow`, which is only readable by root:

```
root:$6$xyz...:19000:0:99999:7::
user:$6$abc...:19000:0:99999:7:::
```

The fields are: username, password hash (or `*`/`!` for locked accounts), days since last password change, minimum days before change, maximum days before change, days before expiration to warn, days after expiration to disable, and days since account was disabled.

Password hashes use strong algorithms:
- `$6$` indicates SHA-512
- `$2y$` indicates bcrypt
- The long string after the dollar sign includes salt (random data that prevents rainbow table attacks) and the hash itself.

### sudo and Privilege Escalation

Root access is powerful but dangerous—a typo or compromised program could destroy the system. **sudo** (superuser do) allows specific users to run commands with elevated privileges while maintaining accountability.

Benefits of sudo over direct root login:
- **Audit trail**: Every sudo command is logged with the user, time, and command
- **Granular control**: Different users can have different permission levels
- **No root password sharing**: Users authenticate with their own passwords
- **Timeout**: sudo permissions expire, reducing window of vulnerability

The sudoers file (`/etc/sudoers` or files in `/etc/sudoers.d/`) defines permissions:

```
# Full root access
user1 ALL=(ALL:ALL) ALL

# Group with full access  
%admin ALL=(ALL:ALL) ALL

# Passwordless specific command
user2 ALL=(ALL) NOPASSWD: /usr/bin/systemctl restart nginx

# Run as another user
user3 ALL=(www-data) /usr/bin/whoami
```

The format is: who=(as_whom) commands. `ALL` is a wildcard. The first `ALL` is which hosts, the `(ALL:ALL)` is which users to run as, and the final `ALL` is which commands.

### PAM (Pluggable Authentication Modules)

Traditional Unix authentication was limited—a single method for verifying users. **PAM** (Pluggable Authentication Modules) provides a flexible framework that allows different authentication methods to be plugged into programs without changing the programs themselves.

When you log in, SSH connects, or authenticate to any PAM-aware service, the service invokes PAM modules in the order specified in the PAM configuration. Each module can:
- Verify credentials
- Set user attributes (home directory, shell, groups)
- Record the session
- Apply resource limits
- Notify on failure

Common PAM modules:
- `pam_unix`: Traditional Unix password authentication
- `pam_sss`: Integration with LDAP or Active Directory
- `pam_limits`: Apply resource limits from /etc/security/limits.conf
- `pam_permit`: Always permits (used as fallback)
- `pam_deny`: Always denies (used to block)
- `pam_pwquality`: Enforces password complexity requirements
- `pam_mkhomedir`: Creates home directory on first login
- `pam_selinux`: Sets SELinux security context
- `pam_cap`: Grants capabilities

PAM configuration lives in `/etc/pam.d/` with separate files for different services:

```
# /etc/pam.d/sshd
auth       include      password-auth
account    include      password-auth
session    include      password-auth
```

---

## 4. Process Management

### What is a Process

A **process** is an instance of a running program. It's the fundamental unit of execution in Linux—a program is code on disk, but a process is that program in action, with its own memory, CPU state, and system resources.

Every process has:
- A unique **Process ID (PID)**, assigned sequentially
- A **Parent Process ID (PPID)**—the process that created it
- A **User ID (UID)** and **Group ID (GID)** determining its permissions
- Its own **address space** (virtual memory)
- **Open file descriptors** (references to open files, sockets, etc.)
- **CPU registers and program counter**—its execution state
- **Environment variables** and **command-line arguments**

When you run a program, the kernel creates a new process to execute it. The first process is PID 1 (init or systemd), which is the ancestor of all other processes—every process either directly or indirectly descends from PID 1.

You can examine processes:

```bash
# Basic process listing
ps aux

# Tree view showing relationships  
ps auxf

# Real-time view
top
htop

# See a specific process
ps -p 1234
cat /proc/1234/status
```

The `/proc` filesystem exposes process information—every running process has a directory `/proc/PID` containing status, memory maps, file descriptors, and more.

### Process States and Lifecycle

A Linux process can be in several states, visible in the STAT column of `ps`:

**Running (R)**: Either currently executing on a CPU core or in the run queue waiting for CPU time. The scheduler continuously switches between running processes, giving each a time slice.

**Sleeping (S)**: Waiting for an event—typically I/O completion, a signal, or a resource. This process can be awakened by signals or I/O completion. "Interruptible sleep" means it can be killed by signals.

**Uninterruptible Sleep (D)**: Usually waiting for I/O and cannot be woken by signals. You'll see this state during disk I/O issues or NFS problems. These processes can't be killed easily—which can be problematic if the underlying I/O is hung.

**Stopped (T)**: Typically stopped by a signal (SIGSTOP, SIGTSTP). This is used by debuggers—you can pause a process, examine its state, and resume it.

**Zombie (Z)**: A process that has terminated but hasn't been "reaped" by its parent. When a process exits, it becomes a zombie until its parent calls `wait()` to retrieve its exit status. Zombies consume only a tiny amount of memory (their process table entry) but should not accumulate. If they do, something is wrong with the parent.

The lifecycle is:

1. **Created**: Parent calls `fork()`, creating a child process
2. **Running**: Process executes, gets CPU time
3. **Waiting**: Process sleeps, waiting for events
4. **Terminated**: Process exits, becomes zombie
5. **Reaped**: Parent calls `wait()`, kernel cleans up

Orphaned processes (parent died) are adopted by init (PID 1), which periodically reaps them.

### The Process Table

The kernel maintains a **process table**—an array or list of all running processes. Each entry (task structure) contains all information about a process.

Key information in the process table:
- **PID and PPID**: Process and parent IDs
- **UID/GID**: User and group IDs
- **State**: Current process state
- **Priority**: Scheduling priority (nice value)
- **Times**: CPU time used (user and system)
- **Memory**: Virtual and resident memory usage
- **Open files**: File descriptor table
- **Credentials**: Security context (capabilities, SELinux context)

You can view detailed process information:

```bash
# Detailed status
cat /proc/1234/status

# Memory maps
cat /proc/1234/maps

# Open files
ls -la /proc/1234/fd

# Command line
cat /proc/1234/cmdline

# Environment
cat /proc/1234/environ
```

### Fork and Exec

Process creation in Unix follows a two-step model: `fork()` then `exec()`. Understanding this pattern is crucial.

**fork()** duplicates the calling process:
- Creates a child process that's a copy of the parent
- Returns twice: once in parent (with child's PID), once in child (with 0)
- Child gets copies of parent's memory, file descriptors, register state
- Copy-on-write optimization makes this efficient—pages are shared until written

After fork, both parent and child continue execution from the same point:

```c
pid = fork();
if (pid == 0) {
    // Child process
    printf("I'm the child, my PID is %d\n", getpid());
} else if (pid > 0) {
    // Parent process  
    printf("I'm the parent, child has PID %d\n", pid);
} else {
    // Error
    perror("fork failed");
}
```

**exec()** replaces the current process's program:
- Doesn't create a new process—transforms the current one
- Replaces the code, data, heap, and stack with the new program
- The PID remains the same

Typically used together: fork creates a child, then the child execs the desired program:

```c
if (fork() == 0) {
    // Child
    execlp("ls", "ls", "-l", NULL);
    // If execlp returns, it failed
    perror("exec failed");
    exit(1);
}
// Parent continues...
```

This separation allows the parent to:
- Spawn multiple children from the same program
- Manage children (wait for them, signal them)
- Pass file descriptors to children

### Signals and Signal Handling

**Signals** are software interrupts sent to processes—a form of asynchronous notification. They're used for:
- Terminating or pausing processes
- Reporting errors
- Inter-process communication
- Handling critical events

When a signal arrives:
1. The kernel interrupts the process
2. If the process has a handler, it's called
3. Otherwise, the default action applies

Common signals:

| Signal | Number | Default | Purpose |
|--------|--------|---------|---------|
| SIGHUP | 1 | Terminate | Terminal closed, config reload |
| SIGINT | 2 | Terminate | Ctrl+C |
| SIGQUIT | 3 | Core dump | Ctrl+\ |
| SIGKILL | 9 | Terminate | Immediate kill (cannot catch) |
| SIGTERM | 15 | Terminate | Graceful termination request |
| SIGSTOP | 19 | Stop | Pause (cannot catch) |
| SIGTSTP | 20 | Stop | Ctrl+Z |

Processes can:
- **Catch** signals (provide a handler function)
- **Ignore** signals (ignore the signal)
- Use **default** action (usually terminate)

```c
#include <signal.h>
#include <stdio.h>

void handle_sigint(int sig) {
    printf("Caught signal %d, but won't exit\n", sig);
}

int main() {
    signal(SIGINT, handle_sigint);
    // Now Ctrl+C won't kill the process
    while(1) sleep(1);
}
```

Many daemons handle SIGHUP to reload configuration without restarting. The convention is:
- Clean up and exit (SIGTERM)
- Ignore during reload (SIGHUP)

### Process Scheduling

The **scheduler** decides which process runs where and for how long. Linux uses the **Completely Fair Scheduler (CFS)**, which aims to give each process a fair share of CPU time.

**Time slicing**: Each process gets a time quantum (typically a few milliseconds). When its quantum expires, the scheduler runs another process. On multi-core systems, each core runs its own scheduler.

**Priority**: CFS uses a "nice" value from -20 (highest priority) to +19 (lowest priority). Lower nice values mean higher priority. Only root can lower nice values below 0:

```bash
# Start with lower priority
nice -n 10 ./program

# Change priority of running process
renice 5 -p 1234
```

**CPU affinity**: By default, Linux migrates processes across cores for load balancing. You can pin processes to specific cores:

```bash
# Pin process to core 0
taskset -c 0 ./program

# View CPU affinity
taskset -p 1234

# Pin an existing process
taskset -cp 0,1 1234  # Pin to cores 0 and 1
```

This matters for NUMA systems and performance-critical applications that benefit from cache locality.

---

## 5. Memory Management

### Virtual Memory Concepts

Linux uses **virtual memory** to give each process its own isolated address space. Virtual memory provides several crucial benefits:

**Isolation**: Each process has its own address space and cannot access another process's memory (without explicit sharing). This provides security and stability—a bug in one program can't corrupt another's memory.

**Simplicity**: Programs can assume they have contiguous memory from address 0 to some maximum, without worrying about what other processes are doing or where physical memory is available.

**Efficiency**: Physical memory can be used more efficiently. Code that's not currently being used can be swapped to disk (or just not loaded). Multiple processes can share read-only pages (like shared libraries).

The virtual address space is typically much larger than physical RAM. On a 64-bit system, the theoretical address space is 2^64 bytes (16 exabytes), though most systems limit it to 128 TB or so for practical reasons.

### Physical vs Virtual Addresses

Physical addresses are actual RAM locations. Virtual addresses are what programs use. The **Memory Management Unit (MMU)**—hardware in the CPU—translates virtual addresses to physical addresses using **page tables**.

When a program accesses a virtual address:
1. The MMU checks if the corresponding physical page is in RAM
2. If yes (page hit), the translation happens in hardware
3. If no (page fault), the CPU triggers a fault
4. The kernel handles the fault:
   - If the page should exist (was swapped out), load it from disk
   - If it's an invalid access, send SIGSEGV to the process

The page tables store these translations. Modern CPUs have a **Translation Lookaside Buffer (TLB)**—a cache of recent translations—to avoid page table lookups.

### Paging and Page Tables

Linux uses a multi-level page table structure (typically 4 levels on x86_64) to efficiently handle large address spaces:

```
Virtual Address:
[ PGD | PUD | PMD | PTE | Offset ]
  9    9    9    9    12 bits  = 39 bits (for 4KB pages)

PGD: Page Global Directory
PUD: Page Upper Directory  
PMD: Page Middle Directory
PTE: Page Table Entry
Offset: 12 bits = 4KB page size
```

Each entry in a page table points to the next level (or to the actual page for PTE). Most virtual addresses are never mapped—sparse address spaces are common. The multi-level structure means unmapped regions don't require page table entries at all levels.

Page table entries store:
- The physical frame number
- Access permissions (read, write, execute)
- Whether the page is present in RAM
- Whether the page has been modified (dirty)

**Huge pages** (2MB or 1GB) reduce page table overhead for large workloads. Transparent HugePages (THP) allow automatic huge page usage without application changes, though this can cause latency issues in some cases.

### Swap Space and Swapping

When physical RAM fills up, Linux moves less-used pages to **swap space**—a disk partition or file. This allows running more programs than RAM can hold, at the cost of dramatically slower access to swapped pages.

The **swapping** process:
1. Kernel selects pages to evict (least recently used algorithm)
2. If the page is modified ("dirty"), writes it to swap
3. Updates page tables to show the page is swapped
4. The physical frame is now free for other pages

Swap is necessary when:
- You genuinely need more memory than you have
- Memory is overcommitted (containers often are)

But swap has costs:
- Disk I/O is orders of magnitude slower than RAM
- Swapping "thrashing" can bring a system to its knees

**vm.swappiness** controls swap aggressiveness:
- 0: Only swap when absolutely necessary (out of memory)
- 60 (default): Balanced
- 100: Aggressive swapping

For most systems, a low swappiness (like 10 or even 1) is better—swap should be emergency memory, not auxiliary storage.

### The OOM Killer

When the system exhausts both RAM and swap, the kernel must free memory. It can't simply crash—it must choose a process to terminate. The **Out-of-Memory (OOM) killer** makes this selection.

The OOM killer uses a scoring algorithm considering:
- **Memory usage**: Processes using more memory are more likely targets
- **oom_score_adj**: Can be set via /proc to influence selection (-1000 to 1000)
- Process importance: Some critical processes are protected
- Children: Process and its children are considered together

The "badness" score roughly equals memory usage divided by total memory:

```bash
# View OOM score for a process
cat /proc/1234/oom_score

# Adjust OOM score (lower = less likely to be killed)
echo -500 > /proc/1234/oom_score_adj

# Prevent process from ever being killed
echo -1000 > /proc/1234/oom_score_adj
```

Production tip: Give critical services (like database) lower OOM scores or run them with memory limits to prevent the OOM killer from choosing them.

### Memory Cgroups

**Control groups (cgroups)** allow grouping processes and applying resource limits to them. The memory controller limits memory usage:

```bash
# Create memory cgroup
mkdir /sys/fs/cgroup/memory/limited-group

# Set memory limit (1GB)
echo 1G > /sys/fs/cgroup/memory/limited-group/memory.limit_in_bytes

# Set memory + swap limit
echo 1G > /sys/fs/cgroup/memory/limited-group/memory.memsw.limit_in_bytes

# Add process to cgroup
echo PID > /sys/fs/cgroup/memory/limited-group/cgroup.procs
```

This is fundamental to container resource limits—each container runs in its own cgroup, and the kernel enforces the memory limits.

---

## 6. Boot Process and Bootloaders

### The Boot Sequence

The Linux boot process involves multiple stages, each loading the next:

1. **Power On**: Hardware initializes, runs Power-On Self Test (POST)
2. **BIOS/UEFI**: Finds and runs bootloader from configured boot device
3. **Bootloader**: Loads kernel and initial ramdisk into memory
4. **Kernel**: Initializes, detects hardware, starts init
5. **Init**: First userspace process, brings system to desired state
6. **Target**: System running (multi-user, graphical, etc.)

Understanding this sequence helps when debugging boot problems or configuring secure boot.

### BIOS and UEFI

**BIOS (Basic Input/Output System)** is the legacy firmware:

- Stored in ROM on the motherboard
- Initializes basic hardware (keyboard, display, storage)
- Reads the first 512 bytes of the boot disk (Master Boot Record)
- Transfers control to the bootloader

Limitations:
- Limited to 2.2TB boot devices (due to MBR limitations)
- No secure boot (can't verify bootloader authenticity)
- Legacy compatibility mode is increasingly irrelevant

**UEFI (Unified Extensible Firmware Interface)** is the modern replacement:

- Stores bootloader in the **EFI System Partition (ESP)**, a FAT-formatted partition
- Supports GPT partition tables (handles disks of any size)
- **Secure Boot** verifies bootloader and kernel signatures, preventing boot-time malware
- Faster boot times
- Standardized interfaces for hardware initialization

Most modern systems ship with UEFI, though BIOS compatibility mode exists for old operating systems.

### Bootloaders: GRUB and systemd-boot

The **bootloader** loads the kernel into memory and executes it. The most common Linux bootloader is **GRUB** (Grand Unified Bootloader).

GRUB's responsibilities:
- Display a menu of available kernels/operating systems
- Allow kernel parameter customization
- Load the selected kernel and initramfs
- Transfer control to the kernel

GRUB configuration lives in `/boot/grub/grub.cfg` (usually generated by `/etc/default/grub` and scripts in `/etc/grub.d/`):

```
# Typical grub.cfg entry:
menuentry 'Ubuntu, with Linux 5.15.0' {
    load_video
    gfxmode $linux_gfx_mode
    insmod gzio
    insmod part_gpt
    insmod ext2
    linux   /boot/vmlinuz-5.15.0 root=UUID=xxx ro quiet splash
    initrd  /boot/initrd.img-5.15.0
}
```

**systemd-boot** (formerly gummiboot) is a simpler bootloader maintained by systemd:

- UEFI-only
- Configuration in `/boot/efi/EFI/*/loader/loader.conf`
- Simpler than GRUB
- Good for systems with simple dual-booting needs

### Kernel Initialization

Once the kernel gains control, it:

1. **Decompresses itself** (if compressed)
2. **Detects CPU**: Identifies processor type, enables features
3. **Detects memory**: Maps physical RAM
4. **Detects devices**: Enumerates hardware
5. **Initializes subsystems**: Memory management, scheduling, networking, etc.
6. **Mounts root filesystem**: From initramfs or specified device
7. **Starts PID 1**: The first userspace process

The **initramfs** (initial RAM filesystem) contains minimal filesystem with drivers needed to mount the real root. On modern systems, this includes storage drivers, filesystem drivers, and possibly decryption tools for LUKS-encrypted partitions.

### Init and the First Process

**PID 1** is special—it's the ancestor of all other processes and handles system-wide responsibilities:

- Adopts orphaned processes
- Reaps zombies
- Manages system services (in modern systems via systemd)
- Handles system shutdown

**systemd** is the dominant init system, replacing the older SysV init. It provides:

- **Parallel service startup**: Dependencies are analyzed, services start concurrently where possible
- **Service management**: Start, stop, restart, enable/disable at boot
- **Socket activation**: Services start on-demand when their socket receives connections
- **Logging**: journald collects service logs
- **Resource control**: cgroup integration for service isolation

---

## 7. Systemd and Service Management

### What is Systemd

**systemd** is the init system for most modern Linux distributions. It started as a replacement for SysV init scripts but evolved into a comprehensive system and service management framework.

Before systemd, SysV init used shell scripts in `/etc/init.d/` with numbered links in `/etc/rc?.d/` directories. Starting services was sequential (one after another), slow, and the scripts varied in quality.

systemd brought:
- **Parallel startup**: Dependencies are analyzed, independent services start simultaneously
- **Activation**: Services can start on-demand (socket, timer, path, bus)
- **Cgroup management**: Resource limits per service
- **Centralized logging**: journald collects all logs
- **Reliable dependency handling**: Clear semantics for ordering

Despite controversy (perceived complexity, design choices), systemd dominates Linux and understanding it is essential.

### Unit Files and Unit Types

systemd manages **units**—objects it knows how to orchestrate. Unit types include:

| Type | Description | Example |
|------|-------------|---------|
| service | Long-running daemon | nginx.service |
| socket | Listening socket | redis.socket |
| device | Hardware device | dev-sda.device |
| mount | Filesystem mount | boot.mount |
| automount | Auto-mount point | data.automount |
| swap | Swap device/file | swap.swap |
| target | Group of units | multi-user.target |
| path | Path monitoring | log.path |
| timer | Scheduled task | backup.timer |
| scope | External process group | session-1234.scope |

Units are defined in **unit files**—configuration files that describe what systemd should manage.

The **system unit directory hierarchy**:
- `/etc/systemd/system/`: Local configuration (wins over packaged units)
- `/run/systemd/system/`: Runtime units (ephemeral)
- `/usr/lib/systemd/system/`: Packaged units (don't edit)

### Service Units Deep Dive

A service unit file describes a long-running process:

```ini
[Unit]
Description=My Application Service
Documentation=https://example.com
After=network.target postgresql.service
Requires=postgresql.service
Wants=redis.service

[Service]
Type=simple
User=appuser
Group=appgroup
WorkingDirectory=/opt/app
Environment="NODE_ENV=production"
EnvironmentFile=/etc/app/env
ExecStartPre=/usr/bin/mkdir -p /var/run/app
ExecStart=/usr/bin/node /opt/app/server.js
ExecReload=/bin/kill -HUP $MAINPID
Restart=always
RestartSec=10
TimeoutStartSec=30
TimeoutStopSec=60
StandardOutput=journal
StandardError=journal
SyslogIdentifier=app

[Install]
WantedBy=multi-user.target
```

Key directives:

- **Type**: `simple` (default, foreground), `forking` (daemonizes), `oneshot` (runs once and exits), `notify` (waits for notification)
- **Restart**: `always`, `on-failure`, `on-abnormal`, `no`
- **After/Before**: Ordering dependencies
- **Requires/Wants**: Mandatory/optional dependencies
- **Environment**: Variables passed to the process

### Targets and Boot Levels

**Targets** group units together to achieve a system state—analogous to SysV runlevels:

| Target | Similar to | Purpose |
|--------|------------|---------|
| emergency.target | Runlevel 1 | Minimal rescue shell |
| rescue.target | Runlevel S | Full rescue mode with networking |
| multi-user.target | Runlevel 3 | Multi-user with networking, text mode |
| graphical.target | Runlevel 5 | Multi-user with graphical login |
| reboot.target | Runlevel 6 | Reboot |
| poweroff.target | Runlevel 0 | Power off |

The **default target** determines what the system boots to:

```bash
systemctl get-default
systemctl set-default multi-user.target
```

You can switch targets at runtime without rebooting:

```bash
systemctl isolate graphical.target
```

### Socket Activation

**Socket activation** allows services to start on-demand when their socket receives a connection. Benefits:

- Services that aren't used don't run (saves resources)
- Faster boot (no need to start all services upfront)
- Better handling of bursts
- Simple dependency management

How it works:

1. systemd creates the listening socket at boot
2. Connection requests queue in the kernel
3. When a connection arrives, systemd starts the service
4. The service inherits the socket and handles the connection

Example with redis:

```ini
# redis.socket
[Unit]
Description=Redis Socket

[Socket]
ListenStream=/var/run/redis/redis.sock
SocketMode=0660
SocketUser=redis
```

When a client connects to the socket, systemd starts redis.service.

### Timers vs Cron

**timers** are systemd's cron replacement with advantages:

- Better dependency handling (start after network-online)
- More precise timing (not limited to minute granularity)
- Automatic retry of missed runs (if system was down)
- Built-in status and management

```ini
# backup.timer
[Unit]
Description=Daily Backup

[Timer]
OnCalendar=daily
Persistent=true
RandomizedDelaySec=1h

[Install]
WantedBy=timers.target

# backup.service (triggered by timer)
[Unit]
Description=Backup Service

[Service]
Type=oneshot
ExecStart=/usr/local/bin/backup.sh
```

Compare to cron:
- Cron jobs aren't automatically retried if missed
- Less visibility in systemctl status
- No dependency ordering built-in
- But cron is simpler for basic needs

### Cgroups and Resource Control

systemd uses **cgroups** (control groups) to track and limit service resources:

- **CPU**: `CPUQuota=50%` — limit CPU to 50% of one core
- **Memory**: `MemoryMax=1G`, `MemoryHigh=800M` — hard and soft limits
- **IO**: `IOWeight=100`, `IOReadBandwidthMax=/dev/sda 10M`
- **Processes**: `TasksMax=50` — limit number of processes

Each service gets its own cgroup in `/sys/fs/cgroup/systemd/`, providing:
- Resource isolation between services
- Accurate accounting of each service's resource usage
- Ability to kill all processes in a service cleanly

```ini
[Service]
MemoryMax=1G
CPUQuota=50%
IOWeight=100
TasksMax=50
```

### Systemd Journal

The **systemd journal** (journald) is systemd's logging solution:

- Binary format, indexed for fast searching
- Structured key-value pairs (not just text)
- Automatic rotation based on size/time
- Includes kernel messages, early boot, service output

**journalctl** queries logs:

```bash
# All logs
journalctl

# Specific unit
journalctl -u nginx
journalctl -u nginx --since "1 hour ago"

# By priority
journalctl -p err

# Follow in real-time
journalctl -f

# Boot-specific
journalctl -b           # Current boot
journalctl -b -1       # Previous boot

# Binary output for parsing
journalctl -o json-pretty
```

The journal can forward to traditional syslog (`/etc/systemd/journald.conf`), providing compatibility with existing log infrastructure.

---

## 8. Networking Fundamentals

### The Network Stack

Linux implements a complete **network stack**—software implementing network protocols that handle everything from electrical signals to application data. This stack follows the **TCP/IP model**, with each layer handling specific responsibilities.

When you visit a website, data flows down through layers on your machine:

1. **Application** (HTTP): Your browser creates an HTTP request
2. **Transport** (TCP): TCP adds port numbers, ensures reliability
3. **Internet** (IP): IP adds source/destination addresses
4. **Link** (Ethernet/WiFi): Adds MAC addresses for local delivery
5. **Physical**: Converts to electrical signals, light, or radio

Each layer adds headers—metadata describing that layer's concerns. The receiving side strips headers and passes data up. This is **encapsulation**.

The stack is **implemented in the kernel** for performance, with user-space libraries (like libc's socket API) providing convenient interfaces.

### TCP/IP Model

The TCP/IP model has four (or five) layers:

**Link Layer** (Network Interface): Handles physical transmission—Ethernet frames, WiFi packets, device drivers. Works with MAC addresses, deals with frames.

**Internet Layer** (Network Layer): Handles addressing and routing—getting packets from source to destination across networks. Works with IP addresses. Key protocols: IP, ICMP.

**Transport Layer**: Provides end-to-end communication. Key protocols:
- **TCP**: Reliable, ordered, connection-oriented
- **UDP**: Fast, unreliable, connectionless

**Application Layer**: HTTP, SSH, DNS, SMTP, etc. The protocols applications actually use.

This layer separation provides flexibility—TCP works over any link layer (Ethernet, WiFi, cellular), and applications don't need to know the details of lower layers.

### IP Addresses and Subnets

An **IP address** identifies a network interface. IPv4 addresses are 32-bit numbers, typically written in dotted-quad notation (192.168.1.1). With 32 bits, there are about 4.3 billion addresses—seemed like plenty in 1980, not enough today.

IPv6 addresses are 128 bits, written as eight groups of four hex digits (2001:0db8:85a3:0000:0000:8a2e:0370:7334), with compression: 2001:db8::1.

A **subnet** groups IP addresses logically. A subnet is defined by an address and a prefix length:

- 192.168.1.0/24 includes 192.168.1.0 through 192.168.1.255 (256 addresses)
- /24 means the first 24 bits are fixed (the network part), the remaining 8 bits are variable (the host part)

The **network address** (first in range) identifies the subnet; the **broadcast address** (last in range) is reserved for broadcast messages.

Private address ranges (non-routable on the internet):
- 10.0.0.0/8
- 172.16.0.0/12
- 192.168.0.0/16

### Ports and Sockets

While IP addresses identify machines, **ports** identify specific services on a machine. A **socket** is the combination of IP address + port—a unique endpoint for communication.

Port numbers:
- **1-1023**: Well-known ports (root required to bind)
- **1024-49151**: Registered ports (applications can register)
- **49152-65535**: Dynamic/ephemeral ports (client side)

Common ports:
- 22: SSH
- 80: HTTP
- 443: HTTPS
- 3306: MySQL/MariaDB
- 5432: PostgreSQL
- 6379: Redis
- 9200: Elasticsearch

A **socket pair** uniquely identifies a connection: (source IP, source port, destination IP, destination port). This is why thousands of clients can connect to a single web server—their sockets differ in source port.

### DNS Resolution

The **Domain Name System (DNS)** maps names to IP addresses. Without DNS, you'd type "142.250.190.46" instead of "google.com".

DNS is hierarchical:
1. Client queries a **resolver** (typically provided by ISP or network)
2. Resolver checks cache, or queries root servers
3. Root servers point to TLD servers (.com, .org, etc.)
4. TLD servers point to authoritative nameservers
5. Authoritative nameserver returns the A/AAAA record

**Record types**:
- **A**: IPv4 address
- **AAAA**: IPv6 address  
- **CNAME**: Canonical name (alias)
- **MX**: Mail exchange
- **TXT**: Text records (SPF, DKIM, DMARC)
- **NS**: Name server
- **SOA**: Start of Authority (zone info)

### Network Namespaces

**Network namespaces** virtualize the network stack. Each namespace has its own:
- Network interfaces
- Routing tables
- iptables rules
- Port space

This is fundamental to containers—each container can have its own network stack with its own IP addresses.

```bash
# Create namespace
ip netns add myns

# Execute in namespace
ip netns exec myns ip addr

# List namespaces
ip netns list
```

---

## 9. Iptables and Firewalls

### What is a Firewall

A **firewall** enforces network security policy by filtering traffic based on rules. Linux's firewall capability is provided by **netfilter**—a kernel framework for packet manipulation—and the user-space tools (iptables, nftables) to manage it.

Firewalls can:
- Allow or deny connections by source/destination IP
- Filter by port and protocol
- Perform Network Address Translation (NAT)
- Limit connection rates
- Inspect application-layer data (with extensions)

### iptables Tables and Chains

iptables organizes rules in **tables** and **chains**:

**Tables** organize rules by function:

- **filter**: Packet filtering (the default table)
- **nat**: Network Address Translation
- **mangle**: Packet modification (TTL, TOS, etc.)
- **raw**: Connection tracking exemptions
- **security**: SELinux markings

**Chains** are ordered lists of rules that packets traverse:

- **INPUT**: Packets destined for local processes
- **OUTPUT**: Packets from local processes
- **FORWARD**: Packets being routed through
- **PREROUTING**: Before routing decision (NAT)
- **POSTROUTING**: After routing decision (NAT)

The packet flow through the system:

```
Incoming packet
    ↓
PREROUTING (NAT, mangle)
    ↓
Routing decision (local or forwarded?)
    ↓
INPUT → Local process
    OR
FORWARD → OUTPUT
    ↓
POSTROUTING (NAT)
    ↓
Outgoing packet
```

### How Packet Filtering Works

Each chain has a **default policy** (ACCEPT or DROP). Rules are evaluated in order; first match wins.

Common actions:
- **ACCEPT**: Let the packet through
- **DROP**: Silently discard (no response to sender)
- **REJECT**: Discard and send ICMP reject
- **LOG**: Log to kernel log
- **RETURN**: Stop processing in this chain

Example: Allow established connections and new SSH:

```bash
# Allow established connections
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# Allow SSH (port 22)
iptables -A INPUT -p tcp --dport 22 -m state --state NEW -j ACCEPT

# Drop everything else
iptables -A INPUT -j DROP
```

The state module (`-m state`) tracks connection state:
- **NEW**: First packet in a connection
- **ESTABLISHED**: Part of an already-established connection
- **RELATED**: Related to an existing connection (e.g., FTP data channel)
- **INVALID**: Packet doesn't match any known connection

### NAT and Masquerading

**Network Address Translation (NAT)** translates between networks. The most common form is **masquerading**—making a private network appear as a single IP address.

**Source NAT (SNAT)** changes the source address (POSTROUTING):
```bash
# SNAT: Change source to 203.0.113.1
iptables -t nat -A POSTROUTING -o eth0 -j SNAT --to-source 203.0.113.1
```

**Destination NAT (DNAT)** changes the destination (PREROUTING or OUTPUT):
```bash
# DNAT: Forward port 80 to internal server
iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 80 -j DNAT --to-destination 192.168.1.10:80
```

**Masquerading** is SNAT with automatic source address detection:
```bash
# Masquerade outgoing traffic
iptables -t nat -A POSTROUTING -s 192.168.0.0/24 ! -o lo -j MASQUERADE
```

This is how home routers work—devices on the private network appear to the internet as a single public IP.

### nftables: The Modern Replacement

**nftables** is the successor to iptables, with advantages:
- Single unified tool (instead of iptables, ip6tables, ebtables)
- Faster packet classification with new nftables hooks in kernel
- Cleaner, more consistent syntax
- Better performance for complex rule sets
- More efficient stateful handling

Same rules in nftables syntax:

```bash
# Add to filter table
nft add table ip filter

# Add to INPUT chain
nft add chain ip filter input '{ policy accept; }'

# Add rules
nft add rule ip filter input ct state established,related accept
nft add rule ip filter input tcp dport 22 accept
nft add rule ip filter input counter drop
```

The transition is gradual—iptables is still widely used, but nftables is the future.

---

## 10. Disk Partitioning and LVM

### Disk Geometry and Partitions

Physical disks have historical **geometry** concepts (heads, cylinders, sectors), though modern LBA (Logical Block Addressing) abstracts these. The disk appears as a linear sequence of sectors, each typically 512 bytes (or 4096 for advanced format).

A **partition** is a logical division of a disk. Partitioning serves:
- Separation of OS and data
- Different filesystems for different needs
- Limiting one partition's growth
- Different mount options per filesystem
- Dual-booting multiple OSes

The **partition table** stores partition information:
- Where partitions start/end
- What type each partition is
- Whether they're bootable

### MBR vs GPT

**MBR (Master Boot Record)** is the legacy scheme:
- 512-byte sector at the start of the disk
- Supports disks up to 2TB
- Maximum 4 primary partitions (or 3 + extended)
- Single bootable partition flag
- Legacy BIOS boot

**GPT (GUID Partition Table)** is modern:
- Part of UEFI standard
- Located in protective MBR plus primary GPT header
- Supports disks up to 256TB (practical limits much lower)
- Up to 128 partitions by default
- Globally unique partition GUIDs
- CRC checksums for integrity
- Redundant GPT headers (at start and end of disk)

For modern systems, GPT is almost always the right choice.

### What is LVM

**LVM (Logical Volume Manager)** adds a layer of abstraction over physical disks, providing:

- **Flexible resizing**: Grow or shrink logical volumes without repartitioning
- **Snapshots**: Point-in-time copies of volumes
- **Thin provisioning**: Overcommit storage
- **RAID integration**: Built-in RAID levels
- **Logical organization**: Volumes independent of physical layout

Think of LVM as a "virtual disk" system—instead of partitioning directly, you create pools of storage (volume groups) and allocate from those pools (logical volumes).

### Physical Volumes, Volume Groups, and Logical Volumes

**Physical Volumes (PVs)**: Disk partitions or whole disks with LVM headers. LVM writes a header to identify them.

**Volume Groups (VGs)**: Pools of storage combining one or more PVs. The VG is the "capacity" you allocate from.

**Logical Volumes (LVs)**: Virtual partitions from a VG. These are what you format and mount.

The hierarchy:

```
Physical Disk → Physical Volume → Volume Group → Logical Volume → Filesystem
/dev/sdb         /dev/sdb1       vg_data         lv_data           /data
```

Commands:

```bash
# Create PV
pvcreate /dev/sdb1 /dev/sdc1

# Create VG
vgcreate vg_data /dev/sdb1 /dev/sdc1

# Create LV
lvcreate -n lv_data -L 100G vg_data

# Or use all free space
lvcreate -n lv_data -l 100%FREE vg_data

# Resize (then resize filesystem)
lvextend -L +50G /dev/vg_data/lv_data
```

### RAID Concepts

**RAID (Redundant Array of Independent Disks)** provides:
- **Performance** through parallelism (striping)
- **Reliability** through redundancy (mirroring, parity)

Common RAID levels:

| Level | Description | Min Disks | Capacity | Fault Tolerance |
|-------|-------------|-----------|-----------|-----------------|
| 0 | Striping | 2 | 100% | None |
| 1 | Mirroring | 2 | 50% | 1 disk |
| 5 | Distributed parity | 3 | (n-1) | 1 disk |
| 6 | Dual parity | 4 | (n-2) | 2 disks |
| 10 | Stripe of mirrors | 4 | 50% | 1/mirror |

**Software RAID** (mdadm) uses kernel and CPU; **hardware RAID** uses dedicated controller with battery-backed write cache. Hardware RAID is generally preferred for performance, but software RAID provides flexibility and works with any disk.

---

## 11. System Logging

### Syslog Architecture

**Syslog** is the traditional Unix logging system, dating back to the 1980s. Applications send log messages to the **syslog daemon** (rsyslog, syslog-ng), which writes them to files based on facility and priority.

The **syslog message** includes:
- **Facility**: What type of program (auth, daemon, kern, mail, user, etc.)
- **Priority/Level**: emerg, alert, crit, err, warning, notice, info, debug
- **Timestamp**: When it happened
- **Hostname**: Where it happened
- **Message**: The actual log content

The configuration (`/etc/rsyslog.conf` or `/etc/syslog-ng/syslog-ng.conf`) determines where messages go based on facility and priority:

```
# Log all errors to /var/log/errors
*.err /var/log/errors

# Mail to its own file
mail.* /var/log/mail.log
```

**rsyslog** is the common syslog daemon with enhancements:
- TCP and UDP forwarding
- Filtering rules
- Template-based formatting
- Reliable delivery with disk queues

### The systemd Journal

The **systemd journal** (journald) is systemd's modern logging solution. It addresses syslog's limitations:

- **Binary format**: Indexed for fast searching, not just text files
- **Structured data**: Key-value pairs, not just plain text
- **Automatic rotation**: Based on size and time limits
- **Includes early boot**: Captures messages from initramfs
- **Better metadata**: Automatic inclusion of unit, PID, UID, etc.

Querying with `journalctl`:

```bash
# By unit
journalctl -u nginx.service

# By time
journalctl --since "2024-01-01 00:00:00"
journalctl --since "1 hour ago"

# By priority (0=emerg, 3=err, etc.)
journalctl -p err

# Follow
journalctl -f

# Binary output
journalctl -o json-pretty
```

The journal can **forward to syslog** (`ForwardToSyslog=yes` in journald.conf), providing compatibility while gaining journal's features.

### Log Rotation

Log files grow indefinitely without management. **logrotate** handles rotation:

- Copies or renames current log
- Creates new log file
- Optionally compresses old logs
- Deletes old logs beyond retention

Configuration in `/etc/logrotate.conf` and `/etc/logrotate.d/`:

```
/var/log/nginx/*.log {
    daily              # Rotate daily
    missingok         # Don't error if missing
    rotate 14        # Keep 14 old files
    compress          # Compress old logs
    delaycompress    # Wait to compress
    notifempty       # Don't rotate if empty
    create 0640 www-data adm  # New file permissions
    sharedscripts    # Run postrotate once
    postrotate
        systemctl reload nginx > /dev/null
    endscript
}
```

### Centralized Logging

For multiple servers, **centralized logging** aggregates logs in one place:

- Cross-system analysis and correlation
- Security auditing
- Compliance requirements
- Easier search and alerting

Common architectures:

- **rsyslog forwarding**: Simple, sends to central rsyslog server
- **ELK Stack**: Elasticsearch (search/analysis), Logstash (processing), Kibana (UI)
- **EFK Stack**: Elasticsearch, Fluentd, Kibana
- **Loki**: Grafana's log aggregation (cheaper than full ELK)
- **Splunk**: Commercial solution

These systems receive logs via:
- Filebeat/Metricbeat (Beats family)
- Fluentd/Fluent Bit
- rsyslog
- Direct API ingestion

---

## Part II: Networking

## 12. TCP and UDP Deep Dive

### TCP vs UDP

**TCP (Transmission Control Protocol)** and **UDP (User Datagram Protocol)** are the two primary transport layer protocols. They represent fundamentally different trade-offs.

**TCP** provides:
- **Reliability**: Lost packets are retransmitted
- **Ordering**: Packets arrive in order
- **Connection**: State is maintained (three-way handshake)
- **Flow control**: Prevents overwhelming receiver
- **Congestion control**: Prevents overwhelming network

Cost: More overhead (20-byte header vs 8 bytes), more latency, potential head-of-line blocking.

**UDP** provides:
- **Simplicity**: Minimal overhead
- **Speed**: No connection setup, no acknowledgment waiting
- **Flexibility**: Application controls everything
- **Broadcast/Multicast**: Easy one-to-many

Cost: No reliability, no ordering, no flow control—application must handle all this.

Choose **TCP** when reliability matters: HTTP, SSH, email, database connections.
Choose **UDP** when speed matters more than reliability: DNS, video streaming, gaming, VoIP, NTP.

### TCP Three-Way Handshake

TCP establishes connections with a **three-way handshake**:

```
Client                                          Server
  |                                               |
  |------------------ SYN ----------------------->|
  |         (seq=x, flags:SYN)                  |
  |                                               |
  |<---------------- SYN-ACK --------------------|
  |         (seq=y, ack=x+1, flags:SYN,ACK)     |
  |                                               |
  |------------------ ACK ---------------------->|
  |         (seq=x+1, ack=y+1, flags:ACK)       |
  |                                               |
  |============ ESTABLISHED ====================|
```

1. **SYN**: Client sends SYN with initial sequence number (x)
2. **SYN-ACK**: Server acknowledges (x+1) and sends its initial sequence (y)
3. **ACK**: Client acknowledges (y+1)

After this, both sides have confirmed they can send to each other. The connection is **ESTABLISHED**.

The initial sequence numbers are random to prevent **TCP sequence prediction attacks**.

### TCP State Machine

A TCP connection goes through various states during its lifetime:

- **CLOSED**: No connection
- **LISTEN**: Server waiting for connections
- **SYN_SENT**: Client sent SYN
- **SYN_RECV**: Server received SYN, sent SYN-ACK
- **ESTABLISHED**: Normal data transfer
- **FIN_WAIT_1**: Sent FIN (close request)
- **FIN_WAIT_2**: Received ACK for FIN_WAIT_1
- **CLOSING**: Both sent FIN simultaneously
- **TIME_WAIT**: Wait for late packets (2MSL)
- **CLOSE_WAIT**: Received FIN, waiting to close
- **LAST_ACK**: Sent FIN after receiving FIN
- **CLOSED**: Connection fully closed

This state machine is why TCP connections sometimes hang—understanding states helps diagnose issues like stuck connections in TIME_WAIT.

### Flow Control and Windowing

**Flow control** prevents the sender from overwhelming the receiver. The receiver advertises a **receive window**—how much buffer space it has available.

The sender limits **unacknowledged data** to the window size. As the receiver processes data, it sends updated window advertisements, allowing the sender to adjust.

**TCP window scaling** extends the 16-bit window field, enabling high-bandwidth connections over high-latency networks. Without scaling, a 1Gbps connection with 100ms RTT would be limited to ~1.25MB throughput (64KB / 0.1s).

### Congestion Control Algorithms

**Congestion control** prevents the sender from overwhelming the network. Several algorithms exist, with different trade-offs:

**Cubic**: The default in Linux. Uses a cubic function to probe for available bandwidth. Excellent for long-distance, high-bandwidth links. "Fast" recovery after loss.

**BBR (Bottleneck Bandwidth and Round-trip propagation time)**: A newer approach focusing on the actual network bottleneck. Can achieve higher throughput with lower latency. Works differently than traditional loss-based algorithms.

**reno**: Classic TCP, simpler but prone to "siloing" in high-bandwidth environments.

**dctcp**: Data Center TCP, optimized for low-latency data center networks with ECN (Explicit Congestion Notification).

The algorithm affects performance significantly—BBR often outperforms Cubic on long-distance/high-BDP (Bandwidth-Delay Product) links.

---

## 13. HTTP and Web Protocols

### HTTP/1.1 Internals

HTTP (Hypertext Transfer Protocol) is the foundation of web communication. HTTP/1.1, standardized in 1999, introduced persistent connections (keep-alive) and remains widespread.

**How HTTP/1.1 works**:
- Client opens TCP connection to server
- Client sends request (method, path, headers)
- Server sends response (status, headers, body)
- Connection can be reused for multiple requests

**Limitations**:
- **Head-of-line blocking**: A slow request blocks subsequent requests on the same connection
- **Plain text headers**: Headers aren't compressed
- **No multiplexing**: Only one request at a time per connection

**Persistence**: By default, HTTP/1.1 keeps connections open. `Connection: close` explicitly closes.

**Pipelining**: Allows sending multiple requests without waiting for responses (rarely implemented due to head-of-line blocking).

### HTTP/2 Improvements

HTTP/2 addresses HTTP/1.1's limitations:

**Binary framing**: Instead of text, data is binary. This is more efficient to parse and enables new features.

**Multiplexing**: Multiple requests/responses stream simultaneously over a single connection. No head-of-line blocking.

**Header compression**: HPACK compresses headers using indexed tables. Significant reduction for repeat headers (cookies, user-agent).

**Server push**: Server can proactively send resources to client before asked (e.g., pushing CSS when HTML is requested).

**Stream prioritization**: Client can indicate which resources are more important, allowing server to send critical assets first.

**Downside**: Still runs over TCP—TCP's head-of-line blocking remains.

### HTTP/3 and QUIC

HTTP/3 uses **QUIC** (Quick UDP Internet Connections), a new transport protocol built on UDP:

**Advantages over TCP**:
- **No head-of-line blocking**: Each stream is independent; losing a packet in one stream doesn't block others
- **0-RTT connection establishment**: Returning clients can send data immediately without round-trip handshake
- **Built-in TLS 1.3**: Encryption is integral
- **Better mobile performance**: Connections survive network changes (WiFi to cellular) better

**Trade-offs**:
- UDP is newer, may be blocked by firewalls
- Different optimization techniques than TCP
- More CPU usage on high-throughput servers

### TLS Handshake

TLS (Transport Layer Security) secures communications:

1. **ClientHello**: Client sends supported cipher suites, random bytes
2. **ServerHello**: Server selects cipher, sends certificate, random bytes
3. **Client verification**: Client verifies server certificate
4. **Key exchange**: Both derive shared keys (typically ECDHE)
5. **Finished**: Both confirm handshake, encrypted data begins

**Full handshake**: 1-3 round trips (depending on resumption)

**0-RTT**: For returning clients, data can be sent immediately. Security trade-off: replay attacks possible.

---

## 14. Load Balancing Theory

### Load Balancing Concepts

A **load balancer** distributes traffic across multiple servers, providing:
- **Capacity**: More servers handle more traffic
- **Reliability**: If one server fails, others take over
- **Geographic distribution**: Direct users to nearest servers

Load balancers are the entry point for most web applications—the client connects to the load balancer, not directly to servers.

### Algorithms and Strategies

**Distribution algorithms**:

| Algorithm | Description | Best For |
|-----------|-------------|----------|
| Round Robin | Cycles through servers | Equal-capacity servers |
| Least Connections | Fewest active connections | Variable request times |
| Least Response Time | Fastest response time | Latency-sensitive |
| IP Hash | Same IP to same server | Session persistence |
| Weighted | Capacity-based | Different server sizes |

**Least Connections** is often best—servers with faster responses naturally get more traffic.

### Health Checks

Load balancers monitor server health:
- **TCP check**: Is the port open?
- **HTTP check**: Does /health return 200?
- **Custom**: Application-specific health endpoint

On failure, traffic is diverted. On recovery, traffic returns. This is **automatic failover**.

### Layer 4 vs Layer 7 Balancing

**Layer 4 (Transport)**: Works at TCP/UDP level
- Faster (less processing)
- Can't inspect application data
- Source IP persistence
- Simpler

**Layer 7 (Application)**: Works at HTTP level
- Can route by URL, headers, cookies
- Can modify requests/responses
- More CPU intensive
- Protocol-aware

Layer 7 is common for web apps. Layer 4 when performance is critical or when non-HTTP protocols are needed.

---

## Part III: Cryptography

## 15. Cryptographic Fundamentals

### Symmetric Encryption

**Symmetric encryption** uses the same key for encryption and decryption. It's the oldest form and much faster than asymmetric encryption.

The challenge: **key distribution**—how do you get the key to the recipient securely?

Common algorithms:
- **AES** (Advanced Encryption Standard): The standard, 128/192/256 bit keys
- **ChaCha20**: Fast, often used in TLS
- **3DES**: Legacy, being phased out

**Modes of operation**:
- **ECB** (Electronic Codebook): Each block encrypted independently. Weak—patterns visible.
- **CBC** (Cipher Block Chaining): Each block XORed with previous ciphertext. Requires padding.
- **GCM** (Galois/Counter Mode): Provides encryption AND authentication. Recommended.

### Asymmetric Encryption

**Asymmetric encryption** uses key pairs: public key encrypts, private key decrypts. This solves key distribution—publish the public key freely, keep private key secret.

The challenge: **computationally expensive**—too slow for large data. Practical use: encrypt a symmetric key, then use symmetric encryption.

Common algorithms:
- **RSA**: Most common, 2048-4096 bit keys
- **ECDH** (Elliptic Curve Diffie-Hellman): Same functionality, much smaller keys
- **Ed25519**: Fast, secure, compact (EdDSA signature scheme)

### Hashing and Message Digests

**Hash functions** produce fixed-size output from any input:
- One-way (can't reverse)
- Deterministic (same input = same output)
- Collision-resistant (hard to find two inputs with same hash)

Common algorithms:
- **SHA-2** (SHA-256, SHA-512): Standard, most common
- **SHA-3**: Different design, less widely adopted
- **bcrypt**: Designed for passwords, includes salt and work factor
- **Argon2**: Modern password hashing, winner of 2015 competition

**Uses**: Password storage, integrity verification, commitment schemes.

### Digital Signatures

**Signatures** prove a message came from the claimed sender:
- Sign with private key
- Verify with public key

Provides **authentication** (who sent it) and **non-repudiation** (can't deny sending).

Common schemes:
- RSA signatures
- ECDSA (Elliptic Curve DSA)
- Ed25519

---

## 16. PKI and Certificates

### What is PKI

**Public Key Infrastructure (PKI)** provides trust through a hierarchy of authorities. It enables:
- Verifying identity of entities
- Establishing secure communications
- Certificate management at scale

### X.509 Certificates

**X.509** is the standard certificate format, containing:
- Subject: Who the certificate is for
- Issuer: Who signed it
- Validity: Not before/not after dates
- Public key: The key being certified
- Extensions: Subject Alternative Names, key usage, etc.
- Signature: Issuer's digital signature

The signature proves the issuer vouches for this public key.

### Certificate Chains and Trust

Trust flows through a **chain**:

```
End-entity certificate
    ↓ signed by
Intermediate CA
    ↓ signed by  
Root CA (trusted anchor)
```

Your computer trusts the **root CA** (bundled in trust store). The intermediate CAs extend trust to end-entity certificates.

### Certificate Authorities

**Root CAs** are self-signed and trusted absolutely. They're bundled with operating systems and browsers. Examples: DigiCert, Comodo, Let's Encrypt.

**Intermediate CAs** are signed by root CAs and sign end-entity certificates. This protects the root—if an intermediate is compromised, only its certificates are affected, not the root.

**Let's Encrypt** provides free certificates via **ACME** (Automated Certificate Management Environment), enabling automated issuance and renewal.

---

## Part IV: Containers

## 17. Container Technology

### What are Containers

**Containers** are lightweight, isolated environments sharing the host kernel. Unlike VMs, they don't include a separate OS—they're processes with isolation.

Benefits:
- **Lightweight**: No duplicate OS memory/CPU overhead
- **Fast**: Start in seconds
- **Efficient**: Higher density than VMs
- **Consistent**: Same environment from dev to production
- **Isolation**: Processes don't interfere

### Namespaces for Isolation

Linux **namespaces** provide isolation:

- **PID**: Separate process ID space (container's PID 1 is not host's PID 1)
- **Network**: Separate network stack (own interfaces, routing, iptables)
- **Mount**: Separate filesystem mounts
- **User**: Separate UID/GID mapping
- **IPC**: Separate inter-process communication
- **UTS**: Separate hostname

These are what containers use—they share the kernel but see different "views" of the system.

### Control Groups (cgroups)

**cgroups** limit and monitor resource usage:

- **CPU**: Limit CPU percentage
- **Memory**: Limit RAM usage
- **I/O**: Limit disk I/O
- **Processes**: Limit number of processes

Without cgroups, containers could monopolize resources. With cgroups, they can be given guaranteed and limited resources.

### Container Images and Layers

Container **images** are templates for containers. They're built from a series of **layers**—each instruction in a Dockerfile creates a layer.

When running a container, there's:
- Read-only image layers
- One writable container layer (thin R/W layer)

Layers are shared between containers—saving space and enabling fast container starts.

### Container Registries

**Registries** store and distribute images:

- **Docker Hub**: Public registry
- **Google Container Registry (GCR)**
- **Amazon Elastic Container Registry (ECR)**
- **GitHub Container Registry (GHCR)**
- **Self-hosted**: Harbor, Nexus

---

## 18. Docker Architecture

### Docker Daemon and Client

Docker uses **client-server** architecture:

- **dockerd** (daemon): Runs on host, builds, runs, manages containers
- **docker** (client): CLI that talks to daemon via REST API
- **API**: Programmatic access

The daemon handles:
- Image management
- Container lifecycle
- Networks
- Volumes

### containerd and OCI

**containerd** is the industry-standard container runtime:
- Manages container lifecycle (create, start, stop)
- Pulls images
- Manages namespaces and cgroups

**OCI** (Open Container Initiative) defines standards:
- **Runtime spec**: How to run containers
- **Image spec**: How images are packaged
- **Distribution spec**: How to distribute images

containerd is OCI-compatible. This means different tools can work together—Docker uses containerd, but so do other systems.

### Storage Drivers

Storage drivers handle image layers and container filesystems:

- **overlay2**: Default, recommended for most. Efficient with many layers.
- **devicemapper**: Legacy, block-based.
- **btrfs**: Copy-on-write native.

The driver must match the backing filesystem.

### Networking Drivers

Docker provides networking options:

- **bridge**: Default NAT'd network
- **host**: Share host's network namespace
- **overlay**: Multi-host networking (Docker Swarm)
- **macvlan**: Direct hardware assignment

---

## 19. Kubernetes Architecture

### Kubernetes Components

**Kubernetes** (k8s) orchestrates containers at scale:

**Control Plane** (master):
- **kube-apiserver**: REST API, the frontend
- **etcd**: Consistent datastore
- **kube-controller-manager**: Runs controllers
- **kube-scheduler**: Assigns pods to nodes

**Worker Nodes**:
- **kubelet**: Agent on each node
- **kube-proxy**: Network proxy
- **container runtime**: Docker, containerd, CRI-O

### The API Server

The **API server** is the heart—everything talks to it:
- REST API for all operations
- Validates requests
- Stores state in etcd
- Enforces authentication/authorization

### etcd: The datastore

**etcd** is a distributed key-value store:
- Holds all cluster state
- Consistent and highly available
- The "source of truth" for Kubernetes

### Controllers and Reconciliation

**Controllers** continuously work toward desired state:
- ReplicaSet: Maintains pod count
- Deployment: Manages rolling updates
- Node: Monitors node health
- Service: Maintains endpoints

This is **declarative**—you say what you want, controllers make it so.

### Scheduler

The **scheduler** assigns pods to nodes:
- Filters nodes that can't run the pod
- Scores remaining nodes
- Picks the winner

---

## Part V: Observability

## 20. Metrics and Monitoring

### What to Monitor

**Four golden signals** (from Google's SRE book):
- **Latency**: Response time
- **Traffic**: Requests per second
- **Errors**: Error rate
- **Saturation**: Resource utilization

Also important:
- Capacity planning
- Business metrics
- Security events

### Push vs Pull Metrics

**Pull model** (Prometheus): Server scrapes metrics from endpoints
- Easier to secure (no open ports)
- Better for dynamic environments
- Centralized collection point

**Push model**: Applications push metrics to collector
- Better for ephemeral tasks
- Can reduce network calls
- Pushgateway for batch jobs

### Prometheus Model

**Prometheus**:
- Time-series database
- Pull-based collection
- PromQL for queries
- Targets expose /metrics endpoint

Metric types:
- **Gauge**: Current value
- **Counter**: Always increasing
- **Histogram**: Distribution

## 21. Logging and Log Analysis

### Log Management Challenges

- Volume: Many sources, high rate
- Format: Different formats
- Retention: How long to keep
- Search: Finding what you need

### Structured Logging

Structured logs are machine-parseable:
- JSON format
- Consistent fields
- Hierarchical data

Benefits: Easy parsing, efficient searching, structured analysis.

### Log Aggregation

Centralize logs from all sources:
- Filebeat → Logstash → Elasticsearch → Kibana
- Fluentd → Elasticsearch
- Promtail → Loki

### Indexing and Search

Elasticsearch:
- Full-text search
- Aggregations
- Dashboards (Kibana)

Loki:
- Label-based filtering
- Cheaper than full indexing

## 22. Distributed Tracing

### The Need for Tracing

In distributed systems, a request spans multiple services. Traditional logging doesn't show the full picture—tracing follows requests end-to-end.

### Traces and Spans

**Trace**: Complete end-to-end request  
**Span**: One operation within a trace

Spans have:
- Operation name
- Start/end times  
- Parent span
- Tags and logs

### Context Propagation

Trace context passes through:
- HTTP headers (W3C Trace Context)
- Message queues
- Database calls

### OpenTelemetry

OpenTelemetry provides:
- Vendor-neutral APIs
- Automatic instrumentation
- Export to Jaeger, Zipkin, Tempo

---

## Part VI: Infrastructure as Code

## 23. Terraform and IaC

### What is Infrastructure as Code

IaC manages infrastructure through code:
- Version control
- Code review
- Reproducibility
- Automation
- Self-documenting

### Declarative vs Imperative

**Declarative**: Define desired state; tool makes it so.
- Terraform, Kubernetes YAML
- Idempotent by nature

**Imperative**: Define steps to achieve state.
- AWS CLI commands
- Ansible (can be both)

### Terraform State

Terraform maintains **state**:
- Maps real resources to configuration
- Tracks dependencies
- Enables planning

State can be local or remote (S3 with state locking, etc.).

### Providers and Resources

**Providers** bridge Terraform and APIs:
- AWS, Azure, GCP
- Kubernetes, Docker
- vSphere, OpenStack

**Resources** are the things to manage.

## 24. Configuration Management

### Ansible Concepts

Ansible is agentless:
- SSH connects to hosts
- Playbooks define desired state
- Modules make changes

### Idempotency

**Idempotent**: Running multiple times produces same result.

Examples:
- "Ensure file exists" = idempotent
- "Append to file" = not idempotent

### Pull vs Push Models

**Push**: Control server pushes to clients
- Ansible, Salt (push)
- Simpler, no agent

**Pull**: Clients pull configuration
- Salt (pull mode), Puppet
- Better for dynamic environments

---

## Part VII: CI/CD

## 25. Pipeline Architecture

### Pipeline Stages

Typical pipeline:
1. **Source**: Code checkout, dependency download
2. **Build**: Compile, bundle
3. **Test**: Unit, integration, e2e
4. **Security**: Scan, SAST/DAST
5. **Deploy**: Staging, production

### Build Strategies

- **Single stage**: All in one job
- **Multi-stage**: Separate jobs, artifacts pass through
- **Matrix**: Multiple combinations
- **Parallel**: Independent jobs run together

### Artifact Management

Build outputs stored:
- Docker images to registry
- Binaries to storage
- Packages to repository

### GitOps Principles

GitOps uses Git as source of truth:
- Infrastructure in Git
- Automated sync (ArgoCD, Flux)
- Drift detection
- Rollbacks via Git

---

## Part VIII: Reliability

## 26. Caching

### Caching Principles

Caching stores frequently-accessed data closer:
- **Browser cache**: Client-side
- **CDN**: Edge locations  
- **Application cache**: In-memory (Redis, Memcached)
- **Database cache**: Query results

### Cache Invalidation

The hardest problem: keeping cache current.
- **TTL**: Time-based expiration
- **Write-through**: Update cache on write
- **Write-behind**: Async cache update
- **Cache-aside**: Application manages

### Redis and Memcached

**Redis**:
- Rich data structures (strings, lists, sets)
- Persistence (RDB, AOF)
- Cluster mode
- Pub/sub

**Memcached**:
- Simple key-value
- Multi-threaded
- No persistence

## 27. Message Queues

### Why Message Queues

Queues provide:
- **Decoupling**: Producers/consumers independent
- **Reliability**: Messages persisted until processed
- **Scalability**: Handle bursts
- **Ordering**: Per-partition ordering

### Publish/Subscribe

**Pub/Sub** broadcasts to subscribers:
- Topic-based filtering
- No persistence (typically)
- Real-time messaging

### Message Ordering and Delivery

Ordering guarantees vary:
- **Per-partition**: Kafka maintains order
- **At-least-once**: Can duplicate
- **Exactly-once**: Requires idempotency

## 28. Database Operations

### Replication Strategies

**Primary-Replica**: One write, multiple reads
- Async (fast, may lose data)
- Semi-sync (waits for one replica)

**Multi-primary**: Multiple write masters
- Complex conflict resolution

### Connection Pooling

Connection pools reuse database connections:
- Avoid connection overhead
- Limit max connections
- Examples: PgBouncer, HikariCP

### Backup Strategies

- **Full**: Complete copy
- **Incremental**: Changes since last backup
- **Point-in-time**: Up to specific timestamp

The **3-2-1 rule**: 3 copies, 2 media types, 1 offsite

## 29. API Gateways

### API Gateway Patterns

Gateways provide:
- Request routing
- Authentication
- Rate limiting
- Protocol translation

### Rate Limiting

Rate limits prevent abuse:
- Per-IP, per-user, per-token
- Token bucket, sliding window
- Graceful handling (retry-after)

### Circuit Breakers

Circuit breakers prevent cascading failures:
- **Closed**: Normal operation
- **Open**: Failing, reject requests
- **Half-open**: Test if recovered

---

## Part IX: Incident Management

## 30. On-Call and Incident Response

### Building an Incident Response Process

Incident response needs:
- Clear ownership
- Communication channels
- Escalation paths
- Runbooks
- Post-mortem process

### Runbooks and Automation

Runbooks document handling:
- Detection steps
- Mitigation steps
- Escalation criteria

Automation handles repetitive tasks.

### Post-Mortems

Blameless post-mortems:
- What happened
- Impact
- Root cause
- Action items
- Learnings

Focus on systems, not people.

## 31. Disaster Recovery

### RTO and RPO

- **RTO**: Maximum acceptable downtime
- **RPO**: Maximum acceptable data loss

These guide backup and recovery strategies.

### Backup Strategies

- **On-site**: Fast recovery
- **Off-site**: Survive site failure
- **Immutable**: Ransomware protection

Test restores regularly!

### Testing Recovery Procedures

Recovery must be practiced:
- Game days
- Chaos engineering
- Regular DR drills
