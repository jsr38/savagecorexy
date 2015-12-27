
use <MCAD/polyholes.scad>;



$fn = 100;

thick = 8;

extrusion_w = 40.0; //mm
extrusion_h = 40.0; //mm
extrusion_bolt_d = 8.0; //mm
extrusion_mount_h = 20.0; //mm

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

union () {
    %translate ([0, 0, thick]) difference () {
        cylinder(r = thick + (nut_i_d / 2.0) + (nut_o_tol / 2.0), h = nut_h - nut_collar_h);
        
    }
    difference () {
        cylinder(r = nut_o_d / 2.0 + thick, h = thick * 2.0);
        cylinder(r = (nut_i_d / 2.0) + (nut_o_tol / 2.0), h = nut_h - nut_collar_h);
        difference() {
            cylinder(r = nut_o_d / 2.0, h = thick);
            translate([nut_o_d / 2.0, 0, thick / 2.0]) cube([nut_o_d - nut_chamfer, nut_chamfer, thick], center = true);
            translate([-nut_o_d / 2.0, 0, thick / 2.0]) cube([nut_o_d - nut_chamfer, nut_chamfer, thick], center = true);
        }
        mount_hole_pair();
        rotate([0, 0, 45.0]) mount_hole_pair();
        rotate([0, 0, -45.0]) mount_hole_pair();
    }
    difference() {
        translate([- (nut_chamfer/2.0) - thick, -nut_chamfer / 2.0, -extrusion_mount_h]) 
        difference () {
            cube([thick, nut_chamfer, extrusion_mount_h]);
            translate([0, nut_chamfer / 2.0, extrusion_mount_h / 2.0]) rotate([0, 90, 0]) polyhole(h = thick, d = extrusion_bolt_d);
        }
    } 
}

module mount_hole_pair() {
    translate([0, nut_mount_pitch / 2.0, thick]) polyhole(d = nut_mount_hole_d, h = thick);
    translate([0, -nut_mount_pitch / 2.0, thick]) polyhole(d = nut_mount_hole_d, h = thick);
}
