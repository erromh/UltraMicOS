# UltraMicOS

**A microkernel you can read in an evening.** Tiny C kernel, userspace servers in modern C++, boots in QEMU.

```
[kernel] entering ring 3
[init]   hello from ring 3 -- C++23, no exceptions, no RTTI
[echo]   got message from tid=3: "sent via ultra::send_typed<T>"
```

## Idea

The kernel does three things and nothing else: **address spaces, threads, IPC.**
Filesystems, drivers and the network stack are ordinary userspace processes talking over messages.

- **Synchronous rendezvous IPC.** `send` blocks until `recv`, one `memcpy`, no queues in the kernel.
- **Control plane / data plane.** 128-byte messages carry metadata, bulk data moves through shared memory.
- **A strict C/C++ boundary.** Only fixed-size POD structs cross it, no exceptions or RTTI.
- **Typed IPC.** C++ templates tie each payload to a message type at compile time.

## Stack

x86-64 · Limine · C kernel · C++20/23 servers · NASM · QEMU

## Layout

```
kernel/     boot, GDT/IDT, PMM/VMM, threads, scheduler, IPC, syscalls, ELF loader
libultra/   C++ runtime and typed IPC wrappers
userspace/  init and servers
common/     the kernel/userspace ABI
```
