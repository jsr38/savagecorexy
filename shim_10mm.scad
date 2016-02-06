

use <MCAD/polyholes.scad>;



$fn = 100;

thick = 10;

extrusion_w = 40.0; //mm
extrusion_h = 40.0; //mm

frame_mount_bolt_r  =  2.575;    //mm
frame_mount_pitch   = 25.4;    //mm

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

mount_length = bearing_o_d + (8 * 2.0) + 30.0;
mount_height = extrusion_h;


difference() {
        
        cube([mount_length, thick, mount_height]);
        translate([mount_length - 10.0 - frame_mount_pitch, -1.0, extrusion_h * 3.0/4.0]) rotate([-90, 0 ,0]) {
            polyhole(d = frame_mount_bolt_r * 2.0, h = thick + 2.0);
            translate([frame_mount_pitch, 0 , 0]) polyhole(d = frame_mount_bolt_r * 2.0, h = thick + 2.0);
        }
        cube([20.0, thick, extrusion_h]);
    }
    
    