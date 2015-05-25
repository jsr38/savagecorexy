
use <rounded-box.scad>;
use <metric-cerberus/metric-cerberus.scad>;

extrusion = 40;   // 40mm x 40mm
tolerance =  0.75; // 0.5mm in each direction
corner_radius = 5.0;
scale_factor = (extrusion + 2.0 * tolerance) / extrusion;  // careful!  We are adopting extrusion_scale from config.scad in the metric-cerberus project.  extrusion_scale=1.02 currently

if (1) {
    echo ("e=", extrusion, " cr=", corner_radius, " t=", tolerance, " s=", scale_factor, "h=", h);
}

if (1) {
    
    foot(extrusion + 10.0, extrusion + 10.0, extrusion - 10);
}

if (0) {
    extrusion4040_no_hole(h=40, mushroom_angles = [0, 90,180,270]);
}

module foot(l, w, h) {
    
    difference() {
        translate([-(l / 2.0 - corner_radius), -(w / 2.0 - corner_radius), 0]) rounded_box(l, w, h, corner_radius);

        scale([scale_factor, scale_factor, 1]) translate([0, 0, h / 2.0]) 
        // cut for extrusion
        extrusion4040_no_hole(h=extrusion / 2.0);
        //scale([scale_factor, scale_factor, 1]) translate([-extrusion / 2.0, -extrusion / 2.0, h / 2.0]) linear_extrude(height = h / 2.0 + 1.0) import("kjn/extrusion.dxf");
        //translate([0, 0, 3.0 * h / 4.0 + 1.0 / 2.0]) cube([7.0, 7.0, h / 2.0 + 1.0], center = true);
    }

}
