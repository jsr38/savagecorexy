
use <rounded-box.scad>;
use <metric-cerberus/metric-cerberus.scad>;



module foot(l, w, h, mushroom_angles = [0, 90,180,270], scale_factor, corner_radius) {
    
    difference() {
        translate([-(l / 2.0 - corner_radius), -(w / 2.0 - corner_radius), 0]) rounded_box(l, w, h, corner_radius);

        scale([scale_factor, scale_factor, 1]) translate([0, 0, h / 2.0]) 
        // cut for extrusion
        extrusion4040_no_hole(h=h / 2.0, mushroom_angles=mushroom_angles);
        //scale([scale_factor, scale_factor, 1]) translate([-extrusion / 2.0, -extrusion / 2.0, h / 2.0]) linear_extrude(height = h / 2.0 + 1.0) import("kjn/extrusion.dxf");
        //translate([0, 0, 3.0 * h / 4.0 + 1.0 / 2.0]) cube([7.0, 7.0, h / 2.0 + 1.0], center = true);
    }

}
