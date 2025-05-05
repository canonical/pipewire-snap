# Containerized Pipewire

This is a snapped version of Pipewire, useful for Ubuntu Core.
It requires a version of snapd with support for the pipewire-server
interface. Without it, it can't work.

## Using it

The pipewire server can be launched either as an user daemon (useful
for Ubuntu Core Desktop) or as a system-wide daemon (for Ubuntu Core
systems). Both are socket-activated, so there's no need to choose
directly which one to use.

The user daemons have their sockets at $XDG_RUNTIME_DIR
(usually /run/user/UID/snap.pipewire, being UID the user ID), while the
system daemons have them at $SNAP_COMMON (/var/snap/pipewire/common).
Since these paths aren’t the default ones, it is mandatory to set
the PULSE_SERVER environment variable pointing to the corresponding
folder: either /run/user/UID for user daemon, or /var/snap/pipewire/common
for the system-wide daemon.

As to have access to the pipewire socket, it not only requires connecting
the pipewire interface, but also setting the PIPEWIRE_RUNTIME_DIR pointing
to either /run/user/UID for user daemon, or to /var/snap/pipewire/common
for the system-wide daemon.

Thanks to the magic of socket activation, only the right daemon will
be launched.

## Known bugs

For some reason, the first access to the pipewire socket fails with a

    stream node 32 error: no target node available
    remote error: id=2 seq:7 res:-2 (No such file or directory): no target node available

error. But the next accesses will work fine. I think that it's due to
the wireplumber daemon not being loaded fast enough.

## Testing it

To do a quick test from the Core command line, just copy a sound file to
`/root/snap/pipewire/common` and run:

    sudo PIPEWIRE_RUNTIME_DIR=/var/snap/pipewire/common snap run pipewire.pw-play /root/snap/pipewire/common/AUDIO-FILE

The first time an error will be shown (check `Known bugs` section), but the next
times it must work as expected.
