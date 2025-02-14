const std = @import("std");
const detect = @import("detect-license");
const expect = @import("expect").expect;

test {
    std.testing.refAllDeclsRecursive(detect);
}
test {
    const alloc = std.testing.allocator;
    const src = @embedFile("./LICENSE");
    const license = try detect.detect(alloc, src);
    try expect(license).toEqualString("MIT");
}
test {
    const alloc = std.testing.allocator;
    const dir = std.fs.cwd();
    const license = try detect.detectInDir(alloc, dir);
    try expect(license).toEqualString("MIT");
}
