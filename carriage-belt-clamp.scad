
m3_diameter = 3.4;

use <belt-clamp_GT2.scad>
use <MCAD/polyholes.scad>
include <microswitch-cutout.scad>
include <hex-nut.scad>

$fn = 100;

thickness = 4.0;

belt_clamp_base_x = 40.0 + 35.0;
belt_clamp_base_y = 20.0 + 20;
belt_clamp_height = 7.0 * 4 + 1.0 + thickness * 2;
belt_clamp_offset_z = 25.0 - 12.625 + 7.0 / 2.0;
belt_clamp_pulley_pitch_z = 7.0 * 2 + 1.0;
belt_clamp_pulley_pitch_y = 22.0 + 1.3;

belt_width = 6.0;
belt_height = 1.8;

mount_hole_x_pitch = 40.0;
mount_hole_y_pitch = 20.0;
mount_hole_r = 2.6;

m3_diameter = 3.4;
m3_nut_diameter = 5.5;
m3_nut_height = 2.4;

clamp_height = 6;
clamp_width = 10;
clamp_length = 18;		// distance between the center of the 2 holes


difference () {
	union() {
		cube([belt_clamp_base_x, belt_clamp_base_y, thickness]);
		cube([thickness, belt_clamp_base_y, belt_clamp_height]);
		translate ([belt_clamp_base_x - thickness, 0, 0]) cube([thickness, belt_clamp_base_y, belt_clamp_height]);

		for (x_i = [ 0 : 1 ]) {
			for (y_j = [ 0 : 1] ) {
			// Add the belt clamps
				
				translate ([x_i * (belt_clamp_base_x - 2 * thickness - clamp_width + 0.02) + thickness + clamp_width / 2.0 - 0.01, 
								y_j * belt_clamp_pulley_pitch_y + (belt_clamp_base_y - belt_clamp_pulley_pitch_y - belt_height) / 2.0 + (((x_i || y_j) && !(x_i && y_j)) ? -clamp_height : -clamp_height),
								belt_clamp_offset_z + (((x_i || y_j) && !(x_i && y_j)) ? 0 : belt_clamp_pulley_pitch_z)])

				rotate([0, 90, 90]) belt_clamp_rear(); 
			}
		}
       
        translate([0,  (microswitch_length + microswitch_surround + microswitch_tol) / 2.0, (microswitch_width + microswitch_surround + microswitch_tol) / 2.0 + thickness]) rotate([90,0,90]) difference() {
            microswitch_surround();
        }
            
        translate([belt_clamp_base_x, belt_clamp_base_y -  (microswitch_length + microswitch_surround + microswitch_tol) / 2.0, (microswitch_width + microswitch_surround + microswitch_tol) / 2.0 + thickness]) rotate([90,0,90]) difference () {
            microswitch_surround();      
        }
	}
    
    translate([0, (microswitch_length + microswitch_surround + microswitch_tol) / 2.0, (microswitch_width + microswitch_surround + microswitch_tol) / 2.0 + thickness]) rotate([90,0,90]) microswitch_cutout();
       
            
    translate([belt_clamp_base_x, belt_clamp_base_y -  (microswitch_length + microswitch_surround + microswitch_tol) / 2.0, (microswitch_width + microswitch_surround + microswitch_tol) / 2.0 + thickness]) rotate([90,0,-90]) microswitch_cutout();
       

	for (x_i = [ 0 : 1 ]) {
		for (y_j = [ 0 : 1] ) {

			// horizontal mounting holes
			translate([x_i * mount_hole_x_pitch + (belt_clamp_base_x - mount_hole_x_pitch)/ 2.0, y_j * mount_hole_y_pitch + (belt_clamp_base_y - mount_hole_y_pitch)/ 2.0, -1.0]) cylinder (r = mount_hole_r, h = thickness + 2.0);


			translate ([x_i * (belt_clamp_base_x - thickness) , y_j * belt_clamp_pulley_pitch_y + (belt_clamp_base_y - belt_clamp_pulley_pitch_y - belt_height) / 2.0, belt_clamp_offset_z - (belt_width + 1.0) / 2.0 + (((x_i || y_j) && !(x_i && y_j)) ? 0 : belt_clamp_pulley_pitch_z)]) cube([thickness + 2.0, belt_height, belt_width + 1.0]);

		}

	}


}

module belt_clamp_rear() {
difference(){
		// basic shape
		union(0){
			translate(v = [0,0,clamp_height/2]) cube([clamp_length,clamp_width,clamp_height], center=true);
			translate(v = [-clamp_length/2, 0, 0]) cylinder(r=clamp_width/2,h=clamp_height);
			translate(v = [clamp_length/2, 0, 0]) cylinder(r=clamp_width/2,h=clamp_height);
			}
		// screw holes
		translate(v = [-clamp_length/2, 0, -1]) polyhole(d = m3_diameter, h=clamp_height+2);
		translate(v = [clamp_length/2, 0, -1]) polyhole(d = m3_diameter, h=clamp_height+2);
        // nut trap
        translate(v = [-clamp_length/2, 0, 0]) rotate([0,0,360/6*3/2]) hex_nut(r = m3_nut_diameter / 2 + microswitch_nut_trap_tol, h = m3_nut_height + microswitch_nut_trap_tol * 2.0);
        translate(v = [clamp_length/2, 0, 0]) rotate([0,0,360/6*3/2]) hex_nut(r = m3_nut_diameter / 2 + microswitch_nut_trap_tol, h = m3_nut_height + microswitch_nut_trap_tol * 2.0);
    }
}


