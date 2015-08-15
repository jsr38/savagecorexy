
/* Based on original design http://www.thingiverse.com/thing:94483

*/

$fn = 100;

thick = 8;
motor_mount_bolt_r  =  2.75;
motor_boss_cutout_r = 19.55;
frame_mount_bolt_r  =  4.15;

is_rh_mount = true;

mirror_y = is_rh_mount ? 1 : 0;


mirror([0,mirror_y,0]) rotate([0,-90,0])

union(){
	translate([0,0,5])
	difference(){
		translate([0,0,0]) cube([thick,65,65]);
		translate([-1,32.5,32.5]) rotate([0,90,0]) cylinder(r = motor_boss_cutout_r, h = thick + 2);
		translate([-1,8.95,8.95]) rotate([0,90,0]) cylinder(r = motor_mount_bolt_r,h = thick+ 2);
		translate([-1,56.05,8.95]) rotate([0,90,0]) cylinder(r = motor_mount_bolt_r,h = thick+ 2);
		translate([-1,8.95,56.05]) rotate([0,90,0]) cylinder(r = motor_mount_bolt_r,h = thick+ 2);
		translate([-1,56.05,56.05]) rotate([0,90,0]) cylinder(r = motor_mount_bolt_r,h = thick+ 2);
	}

	difference(){
		translate([0,0,0]) cube([65,130,thick]);
		translate([20.0, 65.0 + (65.0 - 25.4) / 2.0,-1]) cylinder(r = frame_mount_bolt_r, h = thick+2);
		translate([20.0, 65.0 + (65.0 - 25.4) / 2.0 + 25.4 ,-1]) cylinder(r = frame_mount_bolt_r, h = thick+2);
		translate([65.0, 130.0, -1]) scale([1.0, 65.0 / 25.0, 1.0]) cylinder(r = 25.0, h = thick + 2);
	}

	translate([0,0,0])
	difference(){
		translate([0,0,0]) cube([65,thick/2,55]);
		translate([66.5,thick-1,67.75]) rotate([90,0,0]) cylinder(r=60,h=thick);
	}

	translate([0,65-thick/2,0])
	difference(){
		translate([0,0,0]) cube([65,thick/2,55]);
		translate([66.5,thick-1,67.75]) rotate([90,0,0]) cylinder(r=60,h=thick);
	}

}

