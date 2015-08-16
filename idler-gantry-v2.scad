/* idler-gantry-v2   */


$fn=100;

thickness = 4.0;
width = 35.0;

mount_hole_pitch = 20.0;
mount_hole_r = 2.6;
mount_hole_cs_r = 5.0;
mount_hole_cs_h = 2.8;

sqrt2 = sqrt(2.0);

include <idler-plate.scad>



height = bearing_thickness * 4.0 + 3.0 + 2.0 * thickness;

union () {
	difference() {
		cube([width, thickness, height]);

		translate([width / 2.0 - mount_hole_pitch / 2.0, thickness + 1.0, thickness + 1.0 + bearing_thickness / 2.0]) rotate([90, 0, 0]) cs_hole(mh_r = mount_hole_r, mh_h = thickness, cs_r = mount_hole_cs_r, cs_h = mount_hole_cs_h);
		
		translate([width / 2.0 + mount_hole_pitch / 2.0, thickness + 1.0, thickness + 1.0 + bearing_thickness / 2.0]) rotate([90, 0, 0]) cs_hole(mh_r = mount_hole_r, mh_h = thickness, cs_r = mount_hole_cs_r, cs_h = mount_hole_cs_h);
	}

	idler_plate();

	translate([0.0, 0.0, height - thickness]) idler_plate();

}



module cs_hole(mh_r, mh_h, cs_r, cs_h) {
	union () {
		cylinder(r = mh_r, h = mh_h + 2.0);
		cylinder(r1 = cs_r, r2 = mh_r, h = cs_h);
	}
}