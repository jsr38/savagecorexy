use <foot.scad>;

extrusion     = 40;        // 40mm x 40mm
tolerance     = 0.75;      // 0.5mm in each direction
corner_radius = 5.0;
scale_factor  = (extrusion + 2.0 * tolerance) / extrusion;  // careful!  We are adopting extrusion_scale from config.scad in the metric-cerberus project.  extrusion_scale=1.02 currently

guide_thickness =   3.0;   // mm
guide_length    =  75.0;   // mm
guide_hole_size =   2.0;   // mm diameter 
guide_hole_offsets = [ 30.0, 50.0 ];  // mm
guide_foot_height  = 20.0;   // mm



if (0) {
    echo ("e=", extrusion, " cr=", corner_radius, " t=", tolerance, " s=", scale_factor, "h=", h);
}

if (1) {
    union () {
        foot(extrusion + 10.0, extrusion + 10.0, guide_foot_height);
        translate([0, 0, 0]) difference () {
            union () {
                translate([0, extrusion / 2.0 + guide_thickness / 2.0, guide_length / 2.0])
                cube([25,guide_thickness,guide_length], center=true);
                
                // add some extra support
                for (i = [0 : 1]) {
                        translate([0, extrusion / 2.0 - guide_thickness / 2.0, guide_hole_offsets[i] + guide_foot_height / 2.0])
                        rotate ([90, 0, 0])
                        cylinder(h = guide_thickness, r1 = 4.0, r2 = guide_hole_size / 2.0 + 1.0, $fn = 30, center=true);
                        
                }
            }
            // drill some holes
            for (i = [0 : 1]) {
                translate([0, extrusion / 2.0, guide_hole_offsets[i] + guide_foot_height / 2.0])
                rotate ([90, 0, 0])
                cylinder(h = guide_thickness * 2.0, r = guide_hole_size / 2.0, $fn = 30, center=true);
            }
        }
        
        
    }
}

if (0) {
    extrusion4040_no_hole(h=40, mushroom_angles = [0, 90,180,270]);
}
