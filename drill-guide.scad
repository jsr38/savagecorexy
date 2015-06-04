use <foot.scad>;
use <metric-cerberus/metric-cerberus.scad>

extrusion     = 40;        // 40mm x 40mm
tolerance     = 0.75;      // 0.75mm in each direction
corner_radius = 2.5;
scale_factor  = (extrusion + 2.0 * tolerance) / extrusion;  // careful!  We are adopting extrusion_scale from config.scad in the metric-cerberus project.  extrusion_scale=1.02 currently


// Scale this due to the scaled up cut-out for the extrusion
guide_thickness = (2.5 - (extrusion / 2.0 * (scale_factor - 1.0)));   // mm


guide_length    =  65.0;   // mm
guide_width     =  25.0;   // mm
guide_hole_size =   2.0;   // mm *diameter* 
guide_hole_offsets   = [ 20.0, 30.0, 40.0, 50.0 ];  // mm
guide_support_radius = (8.0 + 2.0) / 2.0; // mm

guide_foot_length  = extrusion + 5.0;
guide_foot_width   = extrusion + 5.0;
guide_foot_height  = 20.0;   // mm



if (1) {
    echo ("e=", extrusion, " cr=", corner_radius, " t=", tolerance, " s=", scale_factor, "h=", h, "gt=", guide_thickness);
}

if (1) {
    
    translate([0,0,guide_foot_width / 2.0]) rotate([-90, 0, 0])
    
    union () {
        difference () {
            foot(guide_foot_length, guide_foot_width, guide_foot_height, corner_radius = corner_radius);
            translate([0, - guide_foot_width / 4.0 , guide_foot_height / 2.0]) cube([guide_foot_length, guide_foot_width / 2.0, guide_foot_height], center = true);
        }
        translate([0, 0, 0]) difference () {
            union () {
                translate([0, (guide_foot_width / 2.0 - guide_thickness / 2.0), guide_length / 2.0])
                cube([guide_width, guide_thickness, guide_length], center=true);
                
                // add some extra support
                for (offset = guide_hole_offsets) {
                        translate([0, extrusion / 2.0 - guide_thickness / 2.0, offset + guide_foot_height / 2.0])
                        rotate ([90, 0, 0])
                        cylinder(h = guide_thickness * 2.0, r1 = guide_support_radius, r2 = guide_hole_size / 2.0 + 1.0, $fn = 30, center=true);
                        
                }
            }
            // drill some holes
            for (offset = guide_hole_offsets) {
                translate([0, extrusion / 2.0, offset + guide_foot_height / 2.0])
                rotate ([90, 0, 0])
                cylinder(h = guide_thickness * (1.0 + 2.0), r = guide_hole_size / 2.0, $fn = 30, center=true);
            }
        }
        
        
    }
}

if (1) {
    //scale_factor = 1.0;
    %color("blue") extrusion4040_no_hole(h=40, mushroom_angles = [0, 90,180,270]);
}
