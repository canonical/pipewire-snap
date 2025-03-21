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
Since these paths aren’t accessible from other snaps, it is a must to
do soft links at the corresponding paths, at least for the PULSE socket.

So, to use the user daemon, just run

    ln -s /var/run/UID/snap.pipewire/pulse /var/run/UID/

and for the system daemon, run

    sudo ln -s /var/snap/pipewire/common/pulse /var/run/

Now, it is paramount to set the PULSE_SERVER environment variable pointing
to the corresponding folder: either /var/run/UID for user daemon, or
/var/run for the system-wide daemon.

Of course, do only one soft link!!!
