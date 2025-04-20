# ArkOS Docker SDK

ArkOS is a linux distribution based on Ubuntu 19.10. For simplicity, I made
a Docker to build quicker my apps on my computer.

This Docker reproduce the ArkOS 2.0 environement as a aarch64 image, it doesn't
provide a full cross-compiling environement.
```bash
$ docker build -f Dockerfile -t arkos-sdk .
# In your project folder...
$ docker run -it --volume=$(pwd):/work/ --workdir=/work/ --rm arkos-sdk
root@920e9eb0a553:/work# # Do stuff here
```
For my Go/Rust projects:
```bash
docker run -d --name go-aarch64 -c 1024 -it --volume=/home/vitaly/GolandProjects/:/work/ --workdir=/work/ rust-aarch64
docker run -d --name rust-aarch64 -c 1024 -it --volume=/home/vitaly/RustroverProjects/:/work/ --workdir=/work/ rust-aarch64
```

On x86, you may need to install qemu-user-static to run the image.

## Files

Here's the content of the repo:
```
Dockerfile - The Docker file (!)
installed.txt - All of the the package installed in Developer Mode
sources.list - The apt sources used by ArkOS
trusted.gpg - The signing keys extracted from ArkOS
```

## License
MIT, see `LICENSE` for details.
