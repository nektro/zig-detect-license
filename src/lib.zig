const std = @import("std");
pub const licenses = @import("licenses-text");
const leven = @import("leven");
const fscheck = @import("fs-check");

pub fn detect(alloc: *std.mem.Allocator, license_src: []const u8) ![]const u8 {
    var min: ?usize = null;
    var ind: ?usize = null;

    for (licenses.spdx) |item, i| {
        const distance = try leven.leven(u8, alloc, license_src, item[1], min);

        if (min == null or distance < min.?) {
            min = distance;
            ind = i;
        }
    }

    return licenses.spdx[ind.?][0];
}

pub fn detectInDir(alloc: *std.mem.Allocator, dir: std.fs.Dir) !?[]const u8 {
    const lic_filename = (try testLicenseFile(dir, "LICENSE")) orelse
        (try testLicenseFile(dir, "LICENSE.md")) orelse
        null;

    if (lic_filename == null) return null;
    const f = try dir.openFile(lic_filename.?, .{});
    defer f.close();
    const b = try f.reader().readAllAlloc(alloc, 1024 * 1024);
    defer alloc.free(b);
    return try detect(alloc, b);
}

//
//

pub fn testLicenseFile(dir: std.fs.Dir, name: []const u8) !?[]const u8 {
    return if (try fscheck.doesFileExist(dir, name)) name else null;
}
