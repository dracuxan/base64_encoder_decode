const std = @import("std");
const structs = @import("root.zig");
const Base64 = structs.Base64;

pub fn main() !void {
    const bits = 0b10010111;
    std.debug.print("{d}\n", .{bits & 0b00110000});
}
