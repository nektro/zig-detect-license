# zig-detect-license

Given an input text guess which SPDX license it most likely is an instance of

## Built With
- https://github.com/ziglang/zig master
- https://github.com/nektro/zigmod package manager

- https://github.com/nektro/zig-licenses-text
- https://github.com/nektro/zig-leven
- https://github.com/nektro/zig-fs-check

## Install
```
zigmod aq add 1/nektro/detect-license
```

## Usage
- `pub fn detect(alloc: *std.mem.Allocator, license_src: []const u8) ![]const u8`
    - Given an input string, will return the SPDX licence identifier for the closest guess to which one it might be

- `pub fn detectInDir(alloc: *std.mem.Allocator, dir: std.fs.Dir) !?[]const u8`
    - Given a directory, will search for a `LICENSE` file and return the guess for which one it is. Will return `null` if the license file can not be found. If this returns null when you do indeed have a license file, please help expand the search examples by submitting a bug report.

## License
MIT
