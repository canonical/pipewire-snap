#!/bin/sh

USER_DIR=/run/user/$(id -u)

cd ${USER_DIR}

echo hola > $USER_DIR/test

rm -f pipewire-*
rm -rf pulse
ln -s snap.pipewire/pipewire-* ./
mkdir -p pulse
cd pulse
ln -s ../snap.pipewire/pulse/native ./
ln -s ../snap.pipewire/pulse/pid ./

echo hola2 >> $USER_DIR/test