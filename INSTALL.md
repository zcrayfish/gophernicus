# Compiling and installing Gophernicus

Gophernicus requires a C compiler but no extra libraries aside
from standard LIBC ones. Care has been taken to use only
standard POSIX syscalls so that it should work pretty much on
any \*nix system.

To compile and install run:

```
$ git clone https://github.com/zcrayfish/gophernicus.git
$ cd gophernicus
$ ./configure --listener=somelistener
$ make
$ make check
$ sudo make install
```

Important configure arguments include:

- `--listener`. If you want `make install` to attempt to
 setup the listener for you, you must choose a listener that
 passes network requests to gophernicus, as gophernicus doesn't
 do this by itself. The options are:
  - systemd, a common init system on many GNU/Linux distributions
    that can do this without an external program.
  - inetd, an older, well-known implementation that is very
    simple. This does not work for busybox inetd.
  - xinetd, a reimplementation of inetd using specific config files.
  - mac, to be used on Mac OSX machines.
  - haiku, to be used on Haiku machines.
  - none, you will manually setup the listener yourself (e.g. ncat, busybox inetd, tcpsvd)
  - autodetect, which looks at what you have available
    (not recommended, please manually specify where possible).
- `--hostname`. This is by default attempted to be autodetected
  by the configure script, using the command `hostname`. It is
  expected to be the publicly-accessible fully qualified domain name (FQDN) of the server.
  However, this detection fails more often than not.
  For testing, just keep the default value of `localhost` which will
  result in selectors working only when you're connecting locally.
- `--gopherroot`. The location in which your gopher server will
  serve from. By default is `/var/gopher`. Also can be changed
  later using the `-r <root>` parameter in configuration files.

That's it - Gophernicus should now be installed, preconfigured
and running under gopher://<HOSTNAME>/. And more often than not,
It Just Works(tm).

## Cross-compiling

Cross-compiling to a different target architecture can be done
by defining HOSTCC and CC to be different compilers. HOSTCC
must point to a local arch compiler, and CC to the target
arch one.

```
$ export HOSTCC=gcc CC=target-arch-gcc
$ ./configure ....
$ make
```

## Shared memory issues

Gophernicus uses SYSV shared memory for session tracking and
statistics. It creates the shared memory block using mode 600
and a predefined key which means that a shared memory block
created with one user cannot be used by another user. Simply
said, running gophernicus under various different user
accounts may create a situation where the memory block is locked
to the wrong user.

If that happens you can simply delete the memory block and
let Gophernicus recreate it - no harm done:

```
$ sudo make clean-shm
```

## Porting to different platforms

If you need to port Gophernicus to a new platform, please take a look at
gophernicus.h which has a bunch of `#define HAVE_...` Fiddling with those
usually makes it possible to compile a working server.
If you succeed in compiling Gophernicus to a new platform please send
the patches to <gophernicus at gophernicus dot org> so we can include
them into the next release -- or even better, commit them to your fork
on Github and make a pull request!

## For packagers

Are you looking to package gophernicus for a Linux
distribution? Thanks! Please see issue #50 to help. Some tips:

- Hostnames will need to be configured by users at runtime, the
  installed gophernicus.env will need to be a config file.
- You probably want to support as many listeners as possible.
  We allow this through the use of a comma seperated list to
  `--listener`.
- The default gopher root is `/var/gopher`; many distributions
  prefer `/srv`.
