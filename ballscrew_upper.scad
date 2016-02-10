
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

microswitch_length              = 20.05;
microswitch_width               =  6.15;
microswitch_height              = 10.25;
microswitch_surround            =  4.00;
microswitch_tol                 =  1.50;
microswitch_screw_pitch         =  9.50;
microswitch_screw_d             =  2.50;
microswitch_screw_h             =  2.90;
microswitch_screw_l_offset      =  5.30;  // initial offset from end
microswitch_screw_head_d        =  4.45;
microswitch_screw_head_h        =  4.50;
microswitch_nut_d               =  5.00;
microswitch_nut_h               =  2.15;
microswitch_nut_trap_tol        =  0.45;
microswitch_nut_trap_h          = 15.00;
microswitch_blade_w             =  3.20;
microswitch_blade_h             =  6.40;   //measured from blade tip to screw hole centre
microswitch_blade_thick         =  0.60;
microswitch_blade_rec_clearance =  3.50;

microswitch_blade_offsets       = [ 1.70, 1.70 + 8.80, 1.70 + 8.80 + 7.30 ];
microswitch_screw_offsets       = [ microswitch_screw_l_offset, microswitch_screw_l_offset + microswitch_screw_pitch ];
microswitch_screw_l             = microswitch_width + microswitch_surround + microswitch_tol * 2.0 + microswitch_nut_h + microswitch_nut_trap_tol * 2.0 + 10.00;

is_y_endstop = true;
is_z_endstop = true;

module hex_nut() {
    n = 6;  // hex nut
    cylinder(h = h, r = r / cos (180 / n), $fn = n);
}

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
    cube([microswitch_length + microswitch_surround + microswitch_tol, microswitch_width + microswitch_surround + microswitch_tol, microswitch_height + microswitch_surround +microswitch_tol], center=true);
}

module microswitch_cutout() {
    union() {
        cube([microswitch_length + microswitch_tol, microswitch_width + microswitch_tol, microswitch_height + microswitch_tol], center=true);
        
        
        // the blade and receptacle cut-outs
        for (blade_offset = microswitch_blade_offsets ) {
            
            translate([blade_offset - microswitch_length / 2.0, 0, (microswitch_height + microswitch_tol) / 2.0 + (microswitch_blade_h - microswitch_screw_h + 2.0) / 2.0]) cube([microswitch_blade_thick + microswitch_blade_rec_clearance / 2.0, microswitch_blade_w + microswitch_blade_rec_clearance / 2.0, microswitch_blade_h - microswitch_screw_h + 2.0], center = true);
        }
        
        // Some space for accessing the receptacles
        translate([0, 0, (microswitch_height + microswitch_surround + microswitch_tol) / 2.0 + microswitch_blade_h - microswitch_screw_h]) cube([microswitch_length + microswitch_tol, microswitch_width + microswitch_tol, (microswitch_height + microswitch_tol) / 2.0], center=true);
        
        // the mounting screw holes
      
        for (screw_offset = microswitch_screw_offsets ) {
            // Translate to correct x,z position, i.e. the correct mount hole placement
            translate([screw_offset - (microswitch_length + microswitch_tol) / 2.0, 0, microswitch_height / 2.0 - microswitch_screw_h]) rotate([90,0,0]) {
                
                // screw cutout
                translate([0, 0, -  (microswitch_width + microswitch_surround + microswitch_tol) / 2.0 - microswitch_screw_head_h - microswitch_nut_trap_tol * 2.0]) {
                    // screw hole
                    polyhole(d = microswitch_screw_d, h = microswitch_screw_l);
                    // screw head
                    polyhole(d = microswitch_screw_head_d + microswitch_nut_trap_tol * 2.0, h = microswitch_screw_head_h + microswitch_nut_trap_tol * 2.0);
                    
                }
                
                // nut trap
                n = 6;
                translate([0, 0, (microswitch_width + microswitch_surround + microswitch_tol) / 2.0]) {
                    rotate([0,0,360/6*3/2]) hex_nut(r = microswitch_nut_d / 2 + microswitch_nut_trap_tol, h = microswitch_nut_h + microswitch_nut_trap_tol * 2.0);
                    translate([-1.0 * (microswitch_nut_d) / 2.0 - 1.0 * microswitch_nut_trap_tol, 0, 0]) rotate([90,0,0]) cube([microswitch_nut_d + microswitch_nut_trap_tol * 2.0, microswitch_nut_h + microswitch_nut_trap_tol * 2.0, microswitch_nut_trap_h]);
                }
            }
            
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