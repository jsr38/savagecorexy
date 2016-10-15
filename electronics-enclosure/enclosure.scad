
// 
//
//

material_thickness = 6.0;  //mm

// Alligator Board cutouts

alligator_board_mount_pitch = [ 157.988, 91.186 ];
alligator_board_mount_r = 1.65;
alligator_board_mount_offset = [ 7.0, 10.0 ];

alligator_board_usb_uart_cutout = [ 157.988, 91.186 ];
alligator_board_usb_uart_offset = [ 7.0, 10.0 ];

alligator_board_usb_mcu_cutout = [ 157.988, 91.186 ];
alligator_board_usb_mcu_offset = [ 7.0, 10.0 ];

// PSU cutouts

psu_mount_pitch = [ 157.988, 91.186 ];
psu_mount_r = 1.65;
psu_mount_offset = [ 7.0, 10.0 ];




module box_faces() {
    linear_extrude(material_thickness, center = true, convexity = 10)   
        import (file = "enclosure.dxf");
}

module alligator_board_cutouts() {

    // Mounting holes

    // USB UART
    
    // USB MCU
    
    // Ethernet
    
    // Micro USB
}

module psu_cutouts() {

    // PSU mounting holes

    // mains inlet
    
    // mains switch

}

module fan_cutouts() {
    // 60mm fan cutout
}

module stepper_wiring_cutouts() {
    
    // 3x stepper wiring cable pass-through cutout
    
    // 3x stepper wiring cable pass-through cutout
    
}

module endstop_wiring_cutouts() { 
    // 2x endstop wiring cable pass-through cutout
}

module thermal_wiring_cutouts() {
    
    // Extruder cooler
    
    // Part cooler
    
    // Hot-end heater
    
    // Hot-end thermistor
    
}

module box_outline() {
    %projection() box_faces();
}


module box() {
    difference() {
        box_faces();
        alligator_board_cutouts();
        psu_cutouts();
        fan_cutouts();
        stepper_wiring_cutouts();
        endstop_wiring_cutouts();
        thermal_wiring_cutouts();
    }
} 

box();

   
