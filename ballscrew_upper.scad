
use <MCAD/polyholes.scad>;



$fn = 100;

thick = 8;

frame_mount_thick = thick + 10.0;  // the Makerslide is 20mm wide, not 40mm

extrusion_w = 40.0; //mm
extrusion_h = 40.0; //mm

frame_mount_bolt_r  =  2.15;    //mm
frame_mount_pitch   = 15.0;    //mm

bearing_o_d   =         22.0;    //mm
bearing_i_d   =          8.0;    //mm
bearing_h     =          7.0;    //mm
bearing_o_tol =          1.0;    //mm

bearing_mount_r = ((bearing_o_d + bearing_o_tol) / 2.0) + thick;

pulley_o_d  = 18.0;  //mm
pulley_i_d  =  8.0;  //mm
pulley_h    = 18.0;  //mm
pulley_t_d  = 12.0;  //mm

ballscrew_length       = 500.0;    //mm
ballscrew_upper_spigot =  20.0;    //mm
ballscrew_lower_spigot =  40.0;    //mm

mount_length = bearing_o_d + (thick * 2.0) + 10.0;
mount_height = extrusion_h;

echo (mount_length);

union() {
    difference() {
        // frame mount
        cube([mount_length, frame_mount_thick, mount_height]);
        translate([mount_length - 7.5 - frame_mount_pitch, -1.0, extrusion_h * 3.0/4.0]) rotate([-90, 0 ,0]) {
            polyhole(d = frame_mount_bolt_r * 2.0, h = frame_mount_thick + 2.0);
            translate([frame_mount_pitch, 0 , 0]) polyhole(d = frame_mount_bolt_r * 2.0, h = frame_mount_thick + 2.0);
        }
        rotate([-90, 0, 0]) union() {
            translate([0, 0, -1.0]) cylinder(r=20, h = frame_mount_thick + 2.0);
            translate([0, -mount_height, -1.0]) scale([1.0, (mount_height - (20.0 + bearing_h * 2.0)) / 20.0, 1.0]) cylinder(r=20, h = frame_mount_thick + 2.0);
        }
    }
    
    translate ([0, -bearing_mount_r + thick, ballscrew_upper_spigot]) difference () {
        cylinder(r = bearing_mount_r, h = bearing_h * 2.0);
        translate ([0, 0, -1.0]) polyhole(d = bearing_o_d + bearing_o_tol, h = bearing_h + 1.5);
        translate ([0, 0, bearing_h - 0.5]) polyhole(d = bearing_i_d + 0.5, h = bearing_h + 1.5);
    }
}