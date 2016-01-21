
/* Based on original design http://www.thingiverse.com/thing:94483

  JSR 21/1/2016 Hacked to for z stage lift motor mount.

*/

$fn = 100;

thick = 8;
motor_mount_bolt_r  =  2.75;
motor_boss_cutout_r = 19.55;
frame_mount_bolt_r  =  4.2;

is_rh_mount = false;

mirror_y = is_rh_mount ? 1 : 0;

pulley_o_d  = 18.0;  //mm
pulley_i_d  =  8.0;  //mm
pulley_h    = 18.0;  //mm
pulley_t_d  = 12.0;  //mm

ballscrew_length       = 500.0;    //mm
ballscrew_upper_spigot =  20.0;    //mm
ballscrew_lower_spigot =  40.0;    //mm


mirror([0,mirror_y,0]) rotate([0,-90,0])

difference() {
    union(){

        translate([0,0,5])
        difference(){
            translate([0,0,0]) cube([thick,65,65]);
            
            translate([-1,8.95,8.95]) rotate([0,90,0]) cylinder(r = motor_mount_bolt_r,h = thick+ 2);
            translate([-1,56.05,8.95]) rotate([0,90,0]) cylinder(r = motor_mount_bolt_r,h = thick+ 2);
            translate([-1,8.95,56.05]) rotate([0,90,0]) cylinder(r = motor_mount_bolt_r,h = thick+ 2);
            translate([-1,56.05,56.05]) rotate([0,90,0]) cylinder(r = motor_mount_bolt_r,h = thick+ 2);
        }

        translate([-36.0,0,0]) difference(){
            translate([0,0,0]) cube([115,65,thick]);
            translate([16.0, (65.0 - 25.4) / 2.0,-1]) cylinder(r = frame_mount_bolt_r, h = thick+2);
            translate([16.0, (65.0 - 25.4) / 2.0 + 25.4 ,-1]) cylinder(r = frame_mount_bolt_r, h = thick+2);
            //translate([65.0 + 36.0, 130.0, -1]) scale([1.0, 65.0 / 45.0, 1.0]) cylinder(r = 45.0, h = thick + 2);
            //translate([36.0 - 20.0, 0.0, -1]) scale([1.0, 65.0 / 20.0, 1.0]) cylinder(r = 20.0, h = thick + 2);
            //translate([32.5,32.5, -1]) cylinder(r = motor_boss_cutout_r, h = thick + 2);
        }
        
        //translate([0,0,0]) cube([65,65,thick]);

        %translate([0,0,0])
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
    //difference
	hull() {
        translate([-1,32.5,32.5 + 5]) rotate([0,90,0]) cylinder(r = motor_boss_cutout_r, h = thick + 2);
		translate([0, 0.0, 32.5 / 2.0 + 5]) cube([thick, 32.5, 32.5]);
	}
}
