id: 2ovav391ivakpt5uh706c38jy7wddi6tqo5rmbdwig9ngkh7
name: detect-license
main: src/lib.zig
license: MIT
description: Given an input text guess which SPDX license it most likely is an instance of
dependencies:
  - src: git https://github.com/nektro/zig-licenses-text
  - src: git https://github.com/nektro/zig-leven
root_dependencies:
  - src: git https://github.com/nektro/zig-expect
