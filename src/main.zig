const std = @import("std");

const detectlicense = @import("detect-license");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const alloc = gpa.allocator();

    const license = try detectlicense.detectInDir(alloc, std.fs.cwd());
    std.debug.assert(std.mem.eql(u8, license.?, "MIT"));
    std.log.info("OK", .{});
}
