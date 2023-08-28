# TexLive-Docker

[![Latest](https://github.com/zydou/texlive/actions/workflows/build-latest.yml/badge.svg)](https://github.com/zydou/texlive/actions/workflows/build-latest.yml)
[![Historic](https://github.com/zydou/texlive/actions/workflows/build-historic.yml/badge.svg)](https://github.com/zydou/texlive/actions/workflows/build-historic.yml)

Docker Image of [TeXLive](http://tug.org/texlive/) with various versions.

~~This project is inspired by [xu-cheng/latex-docker](https://github.com/xu-cheng/latex-docker), which only contains the latest version of TexLive. I make this project to support the historic versions of TexLive.~~

Update: The [xu-cheng/latex-docker](https://github.com/xu-cheng/latex-docker) repository now supports historic versions of TexLive. However, it is based on Alpine and is more suitable for CI than local development. In contrast, this project builds upon the Debian and Ubuntu platforms, rendering it more conducive to local development. This distinction arises from its robust glibc support, facilitating the installation of a wider array of software packages. Notably, this project also includes an `arm64` architecture image, ensuring compatibility with Linux arm64 machines as well as MacBook equipped with Apple silicon chips.

## Supported tags

Tags are formulated as `{texlive_year}-{base_image}]`.

The `texlive_year` refers to the version of TexLive. For instance, if it is set as `2023`, it means that the TexLive version being used is from 2023.

The `base_image` indicates the base image for the Docker image. For example, if it is set as `bullseye`, it signifies that this image is built on Debian Bullseye (also known as Debian 11).

Currently, we support the following choices for `texlive_year` and `base_image`:

| texlive_year | description   |
| ------------ | ------------- |
| latest       | TeX Live 2023 |
| 2023         | TeX Live 2023 |
| 2022         | TeX Live 2022 |
| 2021         | TeX Live 2021 |
| 2020         | TeX Live 2020 |
| 2019         | TeX Live 2019 |
| 2018         | TeX Live 2018 |

| base_image | description  |
| ---------- | ------------ |
| trixie     | Debian 13    |
| bookworm   | Debian 12    |
| bullseye   | Debian 11    |
| buster     | Debian 10    |
| jammy      | Ubuntu 22.04 |
| focal      | Ubuntu 20.04 |
| bionic     | Ubuntu 18.04 |
| xenial     | Ubuntu 16.04 |

Note: You can omit one of the `texlive_year` and `base_image` part. For example:

```sh
zydou/texlive:latest         # latest texlive on newest Debian
zydou/texlive:2022           # texlive-2022 on newest Debian
zydou/texlive:focal       # latest texlive on Ubuntu Focal
zydou/texlive:latest-buster  # latest texlive on Debian Buster
zydou/texlive:2021-jammy  # texlive-2021 on Ubuntu Jammy
```

### Which tag should I choose?

In most cases, you can omit the `base_image` part and simply use the `latest` tag. This tag represents the latest version of TexLive built on the newest Debian release. However, if your project requires a specific texlive version, you can select the corresponding `texlive_year` tag. For instance, if your project needs to be compiled with texlive-2021, choose the `2021` tag.

### When should I care about `base_image`?

Most of the time, you don't need to worry about it. However, on rare occasions, you may find it necessary to use an older version of Debian or Ubuntu.

Since Docker containers utilize the same kernel as the host machine, compatibility between the host kernel and container programs is crucial. For instance, if your Linux machine has a kernel version of 5.4 (such as Ubuntu 18.04) and you launch a container based on Debian Bookworm (which comes with kernel version 6.1), unexpected errors may occur. Compatibility relies on the program's requests to the kernel (system calls) and what features the program expects the kernel to support. Some program requests may cause issues while others do not. Generally speaking, newer versions of kernels are likely compatible with older OS releases but not vice versa. Typically, older debian releases are more likely to be compatible with older machines.

Based on my personal experience, I occasionally need to work on my laboratory's very old workstation running Ubuntu 16.04 (kernel version 4.4). The tags `trixie` (Debian 13) and `bookworm` (Debian 12) do not function properly on this machine. Instead, I have to use either the `bullseye` (Debian 11) or `buster` (Debian 10) tag for compatibility purposes. If you are using a relatively new machine, omitting the `base_image` part should be safe.

If you are using a **very old** machine, start by trying the latest base image to see if it works well. If not, then try older releases. The `buster` or `xenial` tag are most likely compatible with your machine. However, keep in mind that the software included in older base image may be relatively old and could potentially lack certain packages. It's important to note that when I say "the software is relatively old", I am referring to system packages like `git` and `curl` installed through `apt-get install`, not the texlive version. The texlive version remains the same across all different base images.

## Installed packages version

You can check the [pkg-info](https://github.com/zydou/texlive/tree/pkg-info) branch to see the version of installed packages. For example, the [texlive-2023-trixie-amd64/texlive-packages.csv](https://github.com/zydou/texlive/blob/pkg-info/texlive-2023-trixie-amd64/texlive-packages.csv) contains the version of texlive packages installed in the `2023-trixie` image of the `amd64` arch, and the [texlive-2023-bookworm-arm64/system-packages.csv](https://github.com/zydou/texlive/blob/pkg-info/texlive-2023-bookworm-arm64/system-packages.csv) contains the version of system packages installed in the `2023-bookworm` image of the `arm64` arch.

## See Also

- [latex-template](https://github.com/zydou/latex-template): LaTeX Environment with VS Code Remote-Containers and GitHub Codespaces support.
