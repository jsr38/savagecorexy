

module hex_nut(r, h) {
    n = 6;  // hex nut
    cylinder(h = h, r = r / cos (180 / n), $fn = n);
}
