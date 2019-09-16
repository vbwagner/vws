VWS
===

VWs stands for "Virtual WorkStation".

It's main repository, bts and wiki is on [my site](https://wagner.pp.ru/fossil/vws).
See also [manual page](vws.mkd)


It is a python script which provides command-line interface to QEMU
virtual machines, which simplifies such tasks as creation, 
device redirection doing snapshots and reverting to them.

It's main features

- No daemons. No extra processes like libvirtd
- No complicated API like libvirt.
- No XML configs. All configuration of vm is stored in the shell script
  which invokes QEMU with appropriate arguments.
- Transparency. If vws doesn't know how to make something, it doesn't
  prevent you from interacting with QEMU monitor direcrly or editing
  start script by hand.
- Runs as ordinary user. QEMU processes run a invoking user.
  **qemu-bridge-helper** is used to setup network
- Virtual machines can be freely copied from one physical machines to
  another using ordinary file operations. VM directory with virtual disks
  and start script is self-contained.


