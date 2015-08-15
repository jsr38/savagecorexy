/* idler-gantry-v2   */

$fn=100;

bearing_thickness = 7.0;
bearing_od = 22.0;
bearing_id = 8.0;
bearing_shaft_collar= 11.5;
bearing_epsilon = 1.0;

bearing_centre_offset = bearing_od / 2.0 + 10;
bearing_centre_hole_r = 4.25;

mount_hole_pitch = 20.0;
mount_hole_r = 2.6;

sqrt2 = sqrt(2.0);

thickness = 4.0;
width = 35.0;
height = bearing_thickness * 4.0 + 3.0;

union () {
	difference() {
		cube([width, thickness, height]);
		translate([width / 2.0 - mount_hole_pitch / 2.0, 0, thickness + 1.0 + bearing_thickness / 2.0]) rotate([-90, 0, 0]) cylinder(r = mount_hole_r, h = thickness);
		translate([width / 2.0 + mount_hole_pitch / 2.0, 0, thickness + 1.0 + bearing_thickness / 2.0]) rotate([-90, 0, 0]) cylinder(r = mount_hole_r, h = thickness);
	}

	idler_plate();

	translate([0.0, 0.0, height - thickness]) idler_plate();

}

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