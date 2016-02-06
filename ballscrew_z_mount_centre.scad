
use <MCAD/polyholes.scad>;



$fn = 100;

thick = 8;

extrusion_w = 40.0; //mm
extrusion_h = 40.0; //mm
extrusion_bolt_d = 8.0; //mm
extrusion_mount_h = 40.0; //mm

frame_mount_bolt_r  =  2.575;  //mm
frame_mount_pitch   = 25.4;    //mm

nut_o_d      =        42.25;    //mm
nut_i_d      =         24.0;    //mm
nut_h        =         35.5;    //mm
nut_collar_h =          8.5;    //mm
nut_o_tol    =          1.0;    //mm
nut_chamfer =         30.1;    //mm

nut_mount_hole_d =  4.5;    //mm
nut_mount_pitch   = 32.2;    //mm

// this is from the lower ballscrew mount.  TODO:  refactor

bearing_o_d   =         22.0;    //mm
bearing_i_d   =          8.0;    //mm
bearing_h     =          7.0;    //mm
bearing_o_tol =          1.0;    //mm

bearing_mount_r = ((bearing_o_d + bearing_o_tol) / 2.0) + thick;

extrusion_mount_l = (bearing_mount_r + extrusion_w + 25.0 - thick) - (nut_o_tol + nut_chamfer) / 2.0;

union () {
    %translate ([0, 0, thick]) difference () {
        cylinder(r = thick + (nut_i_d / 2.0) + (nut_o_tol / 2.0), h = nut_h - nut_collar_h);
        
    }
    difference () {
        cylinder(r = (nut_o_d + nut_o_tol) / 2.0 + thick, h = thick * 2.0);
        cylinder(r = (nut_i_d / 2.0) + (nut_o_tol / 2.0), h = nut_h - nut_collar_h);
        difference() {
            cylinder(r = (nut_o_d + nut_o_tol) / 2.0, h = thick);
            translate([(nut_o_d + nut_o_tol) / 2.0, 0, thick / 2.0]) cube([nut_o_d - nut_chamfer, nut_chamfer, thick], center = true);
            translate([-(nut_o_d + nut_o_tol) / 2.0, 0, thick / 2.0]) cube([nut_o_d - nut_chamfer, nut_chamfer, thick], center = true);
        }
        mount_hole_pair();
        rotate([0, 0, 45.0]) mount_hole_pair();
        rotate([0, 0, -45.0]) mount_hole_pair();
    }
    // extrusion mount
    union() {
        // the sticky out bit
        difference() {
            translate([(nut_o_tol + nut_chamfer) / 2.0, - extrusion_w / 2.0, 0]) cube([extrusion_mount_l, extrusion_w, thick * 2.0]);
            translate([(nut_o_tol + nut_chamfer) / 2.0 + extrusion_mount_l - thick * 2.0, 0, extrusion_mount_h / 2.0]) rotate([0, 90, 0]) polyhole(h = thick * 2.0, d = extrusion_bolt_d * 2.5);
        }
        // the mount itself
        translate([bearing_mount_r + extrusion_w + 25.0 - thick, - extrusion_w / 2.0, 0]) {
            difference () {
               
                cube([thick, extrusion_w, extrusion_mount_h]);
               
                translate([-1.0, extrusion_w / 2.0, extrusion_mount_h / 2.0]) rotate([0, 90, 0]) polyhole(h = thick + 2.0, d = extrusion_bolt_d);
                
            
                //resize([thick + 2.0, (extrusion_w - thick) * 2.0, thick * 4.0])       translate ([thick / 2.0 + 1.0, extrusion_w + thick, 0]) rotate([0, 90, 0]) cylinder(r= extrusion_w, h = thick + 2.0, center = true);
            }
        }
        // some side supports
        translate([(nut_o_tol + nut_chamfer) / 2.0, extrusion_w / 2.0 - thick, thick * 2.0]) {
            difference() {
                cube([extrusion_mount_l, thick, extrusion_h - thick * 2.0]);
                translate([0, thick + 1.0, extrusion_h - thick * 2.0])  resize([extrusion_mount_l * 2.0, thick + 2.0, (extrusion_h - thick * 2.0) * 2.0]) rotate([90, 0, 0]) cylinder(r = 1, h = 1, center = false);
            }
        }
        translate([(nut_o_tol + nut_chamfer) / 2.0, -extrusion_w / 2.0, thick * 2.0]) {
            difference() {
                cube([extrusion_mount_l, thick, extrusion_h - thick * 2.0]);
                translate([0, thick + 1.0, extrusion_h - thick * 2.0])  resize([extrusion_mount_l * 2.0, thick + 2.0, (extrusion_h - thick * 2.0) * 2.0]) rotate([90, 0, 0]) cylinder(r = 1, h = 1, center = false);
            }
        }
    } 
}

module mount_hole_pair() {
    translate([0, nut_mount_pitch / 2.0, thick]) polyhole(d = nut_mount_hole_d, h = thick);
    translate([0, -nut_mount_pitch / 2.0, thick]) polyhole(d = nut_mount_hole_d, h = thick);
}
