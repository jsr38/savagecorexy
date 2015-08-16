/* idler-v2   */


$fn=100;

thickness = 4.0;
width = 35.0;

mount_hole_pitch = 25.4;
mount_hole_r = 4.2;
mount_hole_cs_r = 5.0;
mount_hole_cs_h = 2.8;

extrusion_width = 40.0;
support_width = 50.0;

sqrt2 = sqrt(2.0);

include <idler-plate.scad>



height = bearing_thickness * 4.0 + 3.0 + 2.0 * thickness;

height_above_extrusion = 25.0 - 12.625 - bearing_thickness / 2.0 - 1.0 - thickness;

difference() {
	union () {
		cube([width, thickness, height + height_above_extrusion]);
		translate ([width - support_width, 0, -extrusion_width]) cube([support_width, thickness, extrusion_width]);
		

		translate([width - support_width, 0, 0]) cube([support_width - width, thickness, thickness]);

		translate([0.0, 0.0, height_above_extrusion]) {
			idler_plate();

			translate([0.0, 0.0, height - thickness]) idler_plate();			translate([1.25, thickness, -thickness]) cube([width - 2.5, thickness, thickness]);
		}
	}
	
	translate([width - support_width / 2.0 - mount_hole_pitch / 2.0, thickness + 1.0, - extrusion_width / 2.0]) rotate([90, 0, 0]) cylinder(r = mount_hole_r, h = thickness + 2.0);
		
	translate([width - support_width / 2.0 + mount_hole_pitch / 2.0, thickness + 1.0, - extrusion_width / 2.0]) rotate([90, 0, 0]) cylinder(r = mount_hole_r, h = thickness + 2.0);

	translate([0.0, 0.0, height_above_extrusion]) translate([-1.0, 2 * thickness, -thickness]) rotate([0, 90, 0]) cylinder(r = thickness, h = width + 2.0);

	 translate ([width - support_width, -1.0, thickness]) scale ([(support_width - width) / thickness, 1.0, 1.0]) rotate ([270, 0, 0]) cylinder(r = thickness, h = thickness + 2.0);

}
