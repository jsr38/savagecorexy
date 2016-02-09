

use <MCAD/polyholes.scad>;

// Electronics mount for Alligator Board

mount_length = 35.00;
mount_width  = 20.00;
mount_height =  5.00;

mount_hole_extrusion_d      =  5.50;
mount_hole_extrusion_offset = 10.00;
mount_hole_board_d          =  3.50;
mount_hole_board_offset     = 25.00;
mount_hole_board_nut_trap_d =  6.00;
mount_hole_board_nut_trap_h =  3.00;

module hex_nut() {
    n = 6;  // hex nut
    cylinder(h = h, r = r / cos (180 / n), $fn = n);
}

difference() {
    cube([mount_length, mount_width, mount_height]);
    // mount holes
    translate([mount_hole_extrusion_offset, mount_width / 2.0, -1.0]) polyhole(d = mount_hole_extrusion_d, h = mount_height + 2.0);
    translate([mount_hole_board_offset, mount_width / 2.0, -1.0]) {
        polyhole(d = mount_hole_board_d, h = mount_height + 2.0);
        hex_nut(r = mount_hole_board_nut_trap_d / 2.0, h = mount_hole_board_nut_trap_h);
    }
}
