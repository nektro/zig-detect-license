const std = @import("std");
pub const licenses = @import("licenses-text");
const leven = @import("leven");
const nfs = @import("nfs");

pub fn detect(alloc: std.mem.Allocator, license_src: []const u8) ![]const u8 {
    var min: ?usize = null;
    var ind: ?usize = null;

    for (licenses.spdx, 0..) |item, i| {
        const distance = try leven.leven(u8, alloc, license_src, item[1], min);

        if (min == null or distance < min.?) {
            min = distance;
            ind = i;
        }
    }
    return licenses.spdx[ind.?][0];
}

pub fn detectInDir(alloc: std.mem.Allocator, dir: nfs.Dir) !?[]const u8 {
    const b = (try testLicenseFile(alloc, dir, "LICENSE")) orelse
        (try testLicenseFile(alloc, dir, "LICENSE.md")) orelse
        (try testLicenseFile(alloc, dir, "LICENSE.txt")) orelse
        return null;
    defer alloc.free(b);
    return try detect(alloc, b);
}

pub fn testLicenseFile(alloc: std.mem.Allocator, dir: nfs.Dir, name: [:0]const u8) !?[]const u8 {
    const file = dir.openFile(name, .{}) catch |err| switch (err) {
        error.ENOENT => return null,
        else => |e| return e,
    };
    defer file.close();
    return try file.readAllAlloc(alloc, 1024 * 1024);
}
