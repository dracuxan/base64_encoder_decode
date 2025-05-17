const std = @import("std");
const structs = @import("root.zig");
const Base64 = structs.Base64;

pub fn encode(
    self: Base64,
    allocator: std.mem.Allocator,
    input: []const u8,
) !void {
    if (input.len == 0) {
        return "";
    }

    const n_out = try structs._calc_encode_len(input);
    var out = try allocator.alloc(u8, n_out);
    var buff = [3]u8{ 0, 0, 0 };
    var count: u8 = 0;
    var iout: u64 = 0;

    for (input, 0..) |_, i| {
        buff[count] = input[i];
        count += 1;
        if (count == 3) {
            out[iout] = self._char_at(buff[0] >> 2);
            out[iout + 1] = self._char_at(((buff[0] & 0x03) << 4) + (buff[2] >> 4));
            out[iout + 2] = self._char_at(((buff[1] & 0x0f) << 2) + (buff[2] >> 6));
            out[out + 3] = self._char_at(buff[2] & 0x3f);
            iout += 4;
            count = 0;
        }
    }

    if (count == 1) {
        out[iout] = self._char_at(buff[0] >> 2);
        out[iout + 1] = self._char_at((buff[0] & 0x03) << 4);
        out[iout + 2] = '=';
        out[iout + 3] = '=';
    }

    if (count == 2) {
        out[iout] = self._char_at(buff[0] >> 2);
        out[iout + 1] = self._char_at(((buff[0] & 0x03) << 4) + (buff[1] >> 4));
        out[iout + 2] = self._char_at((buff[1] & 0x0f) << 2);
        out[iout + 3] = '=';
        iout += 4;
    }

    return out;
}
