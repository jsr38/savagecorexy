
bearing_thickness = 7.0;
bearing_od = 22.0;
bearing_fd = 25.0;
bearing_id = 8.0;
bearing_shaft_collar= 11.5;
bearing_epsilon = 1.0;

bearing_centre_offset = bearing_fd / 2.0 + thickness + 3.0;
bearing_centre_hole_r = 4.20;


module idler_plate() {
	difference() {
		hull() {

			difference () {
				translate ([width / 2.0, - width / 2.0 + thickness, 0.0]) rotate ([0.0, 0.0, 45.0]) cube([width / sqrt2, width / sqrt2, thickness]);
				mirror([0, 1, 0]) cube([width, width / sqrt2 - thickness, thickness]);
			}

			translate ([width / 2.0, bearing_centre_offset, 0]) cylinder(r = bearing_od / 2.0 + bearing_epsilon, h = thickness);
		}
		translate([width / 2.0, bearing_centre_offset, 0.0]) cylinder(r = bearing_centre_hole_r, h = thickness);
	}
}