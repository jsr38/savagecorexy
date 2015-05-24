
use <rounded-box.scad>;

extrusion = 40;   // 40mm x 40mm
tolerance =  0.5; // 0.5mm in each direction

if (1) {
    foot(extrusion + 10.0, extrusion + 10.0, extrusion - 10);
}

module foot(l, w, h) {

corner_radius = 10.0;
scale_factor = (extrusion + 2.0 * tolerance) / extrusion;

//translate([-(l / 2.0 - corner_radius), -(w / 2.0 - corner_radius), 0]) {

    difference() {
        translate([-(l / 2.0 - corner_radius), -(w / 2.0 - corner_radius), 0]) rounded_box(l, w, h, corner_radius);

        scale([scale_factor, scale_factor, 1]) translate([-extrusion / 2.0, -extrusion / 2.0, h / 2.0]) 
        linear_extrude(height = h / 2.0 + 1.0) import("kjn/extrusion.dxf");
    }

//}
}
