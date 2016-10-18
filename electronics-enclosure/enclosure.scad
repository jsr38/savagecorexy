// *************************************************************************
/*
This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

// *************************************************************************

use <../scad-library-jsr/iec_mains_inlet_cutout.scad>;
use <../scad-library-jsr/mains_switch_cutout.scad>;
use <../scad-library-jsr/stand_off.scad>;
use <../scad-library-jsr/screw_holes.scad>;

// The following are taken from the makeabox.io settings
width = 250.0;
height = 250.0;
depth = 50.0;
material_thickness = 6.0;  //mm
notch = 30.0;
kerf = 0.06096;
stroke = 0.0254;
padding = 2.54;
margin = 3.175;

// Alligator Board cutouts

alligator_board_mount_pitch = [ 157.988, 91.186 ];
alligator_board_mount_r = 1.65;
alligator_board_mount_offset = [ 4.6, 25.0, 4.75 ];

// offsets as measured relative to the top left mounting hole
alligator_board_usb_cutout = [ 25.0, 7.25 ];
alligator_board_usb_offset = [ -4.6, 2.0, 4.75 - 7.25 / 2.0 ];

alligator_board_ethernet_cutout = [ 16.5, 13.85 ];
alligator_board_ethernet_offset = [ -4.6, 45.0 ];

alligator_board_microsd_cutout = [ 15.0, 3.0 ];
alligator_board_microsd_offset = [ -4.6, 64.0 ];

// PSU cutouts

psu_mount_pitch = [ 157.988, 91.186 ];
psu_mount_r = 1.65;
psu_mount_offset = [ 7.0, 10.0 ];

psu_mains_inlet_offset = [ 7.0, 10.0 ];

psu_mains_switch_offset = [ 7.0, 10.0 ];

// Fan cutouts



// Stepper wiring cutouts

// End-stop wiring cutouts

// Thermal wiring cutouts

module box_faces() {
    linear_extrude(material_thickness, center = true, convexity = 10)   
        import (file = "enclosure.dxf");
}

module alligator_board_cutouts() {

    // Mounting holes
    screw_holes(pitch_length = alligator_board_mount_pitch[0],
                    pitch_width = alligator_board_mount_pitch[1],
                    pos_vec = "undef",
                    radius, height, cs = false);
    screw_holes();


    // micro USB x2
    
    // Ethernet
    
    // Micro SD card
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

   
