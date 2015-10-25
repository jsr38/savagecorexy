


extrusion_width     = 40.0;        // 40mm x 20mm
extrusion_height    = 20.0;

tolerance     = 0.25;      // 0.25mm extra room to fit around the   extrusion


guide_length    = 65.0;              // mm
guide_width     = extrusion_width;   // mm
guide_thickness =  4.0;              // mm

guide_overhang_r  =  5.0;              // mm
guide_overhang_f  = 25.0;              // mm

guide_hole_size =   0.75;   // mm *diameter* 
guide_hole_offsets   = [ 10.0, 30.0 ];  // mm
guide_hole_offsets_y = [ 20.0, 20.0 ];  // mm


guide_support_radius = (8.0 + 2.0) / 2.0; // mm

guide_foot_length  = extrusion + 5.0;
guide_foot_width   = extrusion + 5.0;
guide_foot_height  = 20.0;   // mm


union() {

	cube([guide_width, guide_thickness, guide_overhang_r]);

	rotate([-90, 0, 0]) cube([guide_width, guide_thickness, extrusion_height + guide_thickness * 2.0 + tolerance]);

	translate([0, extrusion_height + guide_thickness + tolerance]) { 
		difference() {
			cube([guide_width, guide_thickness, guide_overhang_f]);
			rotate([-90, 0, 0]) {
				translate ([guide_hole_offsets[0], -guide_hole_offsets_y[0], -0.5]) {
					cylinder(r=guide_hole_size, h=guide_thickness+ 1.0, $fn = 30);
				
				}
				translate ([guide_hole_offsets[1], -guide_hole_offsets_y[1], -0.5]) {
					cylinder(r=guide_hole_size, h=guide_thickness+1.0, $fn=30);
				
				}
			}
		}
	}
}
