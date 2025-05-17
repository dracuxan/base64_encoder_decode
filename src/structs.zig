const std = @import("std");
pub const Base64 = struct {
    _table: *const [64]u8,

    pub fn init() Base64 {
        const upper = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        const lower = "abcdefghijklmnopqrstuvwxyz";
        const num_symb = "0123456789+/";

        return Base64{
            ._table = upper ++ lower ++ num_symb,
        };
    }

    pub fn _char_at(self: Base64, index: usize) u8 {
        return self._table[index];
    }
};

pub fn _calc_encode_len(input: []const u8) !usize {
    if (input.len < 3) {
        return 4;
    }
    const n_group: usize = try std.math.divCeil(usize, input.len, 3);
    return n_group * 4;
}

pub fn _calc_decode_len(input: []const u8) !usize {
    if (input.len < 4) {
        return 3;
    }
    const n_group: usize = try std.math.divFloor(usize, input.len, 4);

    var mult_groups: usize = n_group * 3;
    var i: usize = input.len - 1;
    while (i > 0) : (i -= 1) {
        if (input[i] == '=') {
            mult_groups -= 1;
        } else {
            break;
        }
    }
    return mult_groups;
}
