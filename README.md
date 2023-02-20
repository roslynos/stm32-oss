# RoslynOS Build System

RoslynOS is a open-source [.NET runtime](https://dotnet.microsoft.com/) platform based on OpenEmbedded and optimized for IoT devices. 

RoslynOS Linux is built around busybox and systemd. This makes it small and very resource efficient. A bare metal deployment requires no more than 8 MB memory and a minimal installation to disk requires around 200 MB of storage. Devices typically take about 12 seconds to boot.

You can [download](https://github.com/roslynos/stm32-oss/releases) prebuilt images or fully build a flashable image from source with the following commands, but be careful it will take several hours:

NOTE: THESE IMAGES ARE BETA AND AT THIS POINT DO NOT INCLUDED ANY SECURITY HARDENING. USE AT YOUR OWN RISK.

## Clone the Repository

If you haven't set a global git name and email yet, adapt the following git config commands to your information. (This is required to clone some git repositories when building.)

```bash
git config --global user.email "you@example.com"
git config --global user.name "Your Name"
```

Clone the main repository using the following command:

```bash
git clone https://github.com/roslynos/stm32-oss.git
```

Before you continue to Build, make sure you're in the roslyn directory:
```bash
cd stm32-oss
./run-build.sh install
./run-build.sh init
```

Build RoslynOS
```bash
./run-build.sh
```

## Using minicom command to connect via console
```bash
sudo minicom -D /dev/ttyUSB0 115200
```

# Give a Star! :star:

If you like or are using this project to start your solution, please give it a star. Thanks!

# Contributions

Contributions to this project are always welcome. Please consider forking this project on GitHub and sending a pull request to get your improvements added to the original project.

# Licenses

A RoslynOS image is made of many components and it’s hard to describe the full details of all the licenses that are in use in the system. However, when building the system from sources with OpenEmbedded, one can find the exhaustive set of licenses used by each package in the `build/tmp/deploy/licenses` directory.

# Disclaimer

All source, documentation, instructions and products of this project are provided as-is without warranty. No liability is accepted for any damages, data loss or costs incurred by its use.


# stm32mp-os

[stm32mp157f-dk2](https://www.st.com/en/evaluation-tools/stm32mp157f-dk2.html)
[stm32mp157f-dk2 tutorial](https://github.com/darkquesh/stm32mp1)
[ST website](https://wiki.st.com/stm32mpu/wiki/Category:STM32MP15x)
