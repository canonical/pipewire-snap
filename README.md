# Containerized Pipewire

This is a snapped version of PipeWire for Ubuntu Core.

It requires a version of snapd with support for the `pipewire` system-daemon
socket paths (snapd 2.71+).

## Runtime model

This snap runs PipeWire as a **system daemon** and exposes sockets under:

- `/var/snap/pipewire/common/pipewire-0`
- `/var/snap/pipewire/common/pulse/native`

Command-line tools inside this snap default to this runtime directory.
For external clients/snaps, use:

- `PIPEWIRE_RUNTIME_DIR=/var/snap/pipewire/common`
- `PULSE_SERVER=/var/snap/pipewire/common`

## Quick test on Core

```bash
snap run pipewire.pw-cli info 0
snap run pipewire.pw-dump
snap run pipewire.wpctl status
```
