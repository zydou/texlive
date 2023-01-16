# TexLive-Docker

[![Latest](https://github.com/zydou/texlive/actions/workflows/update-latest.yml/badge.svg)](https://github.com/zydou/texlive/actions/workflows/update-latest.yml)
[![Historic](https://github.com/zydou/texlive/actions/workflows/build-historic.yml/badge.svg)](https://github.com/zydou/texlive/actions/workflows/build-historic.yml)

Docker Image of [TeXLive](http://tug.org/texlive/) with various schemes.

This project is inspired by [xu-cheng/latex-docker](https://github.com/xu-cheng/latex-docker), which only contains the latest version of TexLive. I make this project to support the historic versions of TexLive.

## Supported tags
Tags are formatted as `{year|latest}-{scheme}[-doc][-vscode][-nightly-{year}-{month}-{day}]`.

Currenly, tags with `latest` is the same as `2022`. Tags only contains `year` is the same as `year-full`.

For example, `latest` and `2022` and `latest-full` and `2022-full` are the same as each other.

Full list of tags as follows:

- Without docs
  -  `latest`, `latest-full`, `latest-medium`, `latest-small`, `latest-basic`
  -  `2022`, `2022-full`, `2022-medium`, `2022-small`, `2022-basic`
  -  `2021`, `2021-full`, `2021-medium`, `2021-small`, `2021-basic`
  -  `2020`, `2020-full`, `2020-medium`, `2020-small`, `2020-basic`
  -  `2019`, `2019-full`, `2019-medium`, `2019-small`, `2019-basic`
  -  `2018`, `2018-full`, `2018-medium`, `2018-small`, `2018-basic`

- With docs
  -  `latest-doc`, `latest-full-doc`, `latest-medium-doc`, `latest-small-doc`, `latest-basic-doc`
  -  `2022-doc`, `2022-full-doc`, `2022-medium-doc`, `2022-small-doc`, `2022-basic-doc`
  -  `2021-doc`, `2021-full-doc`, `2021-medium-doc`, `2021-small-doc`, `2021-basic-doc`
  -  `2020-doc`, `2020-full-doc`, `2020-medium-doc`, `2020-small-doc`, `2020-basic-doc`
  -  `2019-doc`, `2019-full-doc`, `2019-medium-doc`, `2019-small-doc`, `2019-basic-doc`
  -  `2018-doc`, `2018-full-doc`, `2018-medium-doc`, `2018-small-doc`, `2018-basic-doc`

## How to use
The images are published to [Docker Hub](https://hub.docker.com/r/zydou/texlive) and [GitHub Container Registry](https://github.com/zydou/texlive/pkgs/container/texlive)
* [Docker Hub](https://hub.docker.com/r/zydou/texlive)

```bash
docker pull zydou/texlive:2021-full  # or any other tag
```

* [GitHub Container Registry](https://github.com/zydou/texlive/pkgs/container/texlive)

```bash
docker pull ghcr.io/zydou/texlive:2021-full  # or any other tag
```

## See Also
- [latex-template](https://github.com/zydou/latex-template): LaTeX Environment with VS Code Remote-Containers and GitHub Codespaces support.
