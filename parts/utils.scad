
module trapezoid(len1, len2, h, thickness, top_offset_x = 0) {
    linear_extrude(height=thickness, center=true, scale = 1.0, $fn = 16) {
        polygon(points = [
            [-len1/2, -h/2],
            [len1/2, -h/2],
            [len2/2 + top_offset_x, h/2],
            [-len2/2 + top_offset_x, h/2],
        ]);
    }
}

