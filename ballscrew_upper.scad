
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
bearing_o_tol =          0.5;    //mm

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

microswitch_length    =  19.8;
microswitch_width    =    6.0;
microswitch_height    =  10.6;
microswitch_surround =    4.0;
microswitch_tol       =    0.5;
microswitch_screw_pitch = 9.50;
microswitch_screw_d =    2.5;
microswitch_screw_h =    2.9;
microswitch_screw_l_offset = 5.30;
microswitch_blade_w  =    3.20;
microswitch_blade_h  =    6.40;   //measured from blade tip to screw hole centre
microswitch_blade_thick =  0.6;
microswitch_blade_rec_clearance = 2.50;

microswitch_blade_offsets = [ 1.70, 1.70 + 8.80, 1.70 + 8.80 + 7.30 ];
microswitch_screw_offsets = [ microswitch_screw_l_offset, microswitch_screw_l_offset + microswitch_screw_pitch ];

is_y_endstop = true;

module frame_mount() {
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
}

module microswitch_surround() {
    cube([microswitch_length + microswitch_surround, microswitch_width + microswitch_surround, microswitch_height + microswitch_surround], center=true);
}

module microswitch_cutout() {
    union() {
        cube([microswitch_length + microswitch_tol, microswitch_width + microswitch_tol, microswitch_height + microswitch_tol], center=true);
        // the blade and receptacle cut-outs
        for (blade_offset = microswitch_blade_offsets ) {
            echo(blade_offset);
            translate([blade_offset - microswitch_length / 2.0, 0, (microswitch_height + microswitch_surround) / 2.0 + 1.0]) cube([microswitch_blade_thick + microswitch_blade_rec_clearance / 2.0, microswitch_blade_w + microswitch_blade_rec_clearance / 2.0, microswitch_blade_h - microswitch_screw_h + 2.0], center = true);
        }
        // the mounting screw holes
      
        for (screw_offset = microswitch_screw_offsets ) {
            echo(screw_offset);
            translate([screw_offset - microswitch_length / 2.0, (microswitch_width + microswitch_surround) / 2.0,0]) rotate([90,0,0]) polyhole(d = microswitch_screw_d, h = microswitch_width + microswitch_surround);
        }
       
    }
}


union() {
    
    translate ([0, -1.0 * (bearing_mount_r - thick), ballscrew_upper_spigot]) {
        difference() {  
                union() {
                    // frame mount
                    //reverse out the translation :-( should be only one rotate-translate-scale :-(
                    translate ([0, 1.0 * (bearing_mount_r - thick), -1.0 * ballscrew_upper_spigot]) frame_mount();
                    // bearing mount
                    cylinder(r = bearing_mount_r, h = bearing_h * 2.0);
                    // end-stop microswitch 
                    translate([-bearing_mount_r, 0, bearing_h]) {
                        rotate([0,0,90]) {
                            microswitch_surround();
                        }
                    }
                    translate([0, (bearing_mount_r - thick) + frame_mount_thick / 2.0, bearing_h]) {
                        rotate([0,90,0]) {
                            microswitch_surround();
                        }
                    }
                }
                // bearing receptacle
                translate ([0, 0, -1.0]) polyhole(d = bearing_o_d + bearing_o_tol, h = bearing_h + 1.5);
                translate ([0, 0, bearing_h - 0.5]) polyhole(d = bearing_i_d + 0.5, h = bearing_h + 1.5);
                // cutout for end-stop microswitch
                translate([-bearing_mount_r,0,-microswitch_surround / 2.0 - 1.0 + bearing_h]) {
                    rotate([0,0,90]) {
                        microswitch_cutout();
                    }
                }
                translate([-microswitch_surround / 2.0, (bearing_mount_r - thick) + frame_mount_thick / 2.0, bearing_h]) {
                    rotate([0,90,0]) {
                        microswitch_cutout();
                    }
                }
        }
    }
}