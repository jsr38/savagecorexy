

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

module microswitch_surround() {
    cube([microswitch_length + microswitch_surround + microswitch_tol, microswitch_width + microswitch_surround + microswitch_tol, microswitch_height + microswitch_surround +microswitch_tol], center=true);
}

module microswitch_cutout() {
    translate([0,0,-microswitch_surround / 2.0 - 1.0]) union() {
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