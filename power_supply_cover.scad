show_assembly = false; // Set to false to only show the part

power_supply_depth = 215;
power_supply_width = 114;
power_supply_height = 50;
power_supply_wall_thickness = 1.5;
power_supply_cutout_depth = 16; // cutout for terminals
power_supply_cutout_height = 42; // from top
power_supply_slot_depth_offset = 5.4; // from front
power_supply_slot_bottom_offset = 11.25;
power_supply_slot_dia = 2.88; // to be verified
power_supply_slot_height = 25;
power_supply_width_pot_offset = power_supply_width/2 - 14;
power_supply_width_led_offset = power_supply_width/2 - 7;
power_supply_depth_pot_offset = 7; // From cutout edge, also used for the led
power_supply_screw_bank_width = 87.5;
power_supply_screw_bank_height = 20;
power_supply_screw_bank_right_offset = 5;

connector_front_height = 22;
connector_front_width = 30.45;
connector_front_depth = 4.75;
connector_contact_depth = 10;
connector_depth = 28; // including everything
connector_body_depth = connector_depth - connector_front_depth - connector_contact_depth;
connector_body_height = 18.8;
connector_body_width = 26.95;
connector_has_wings = true;
connector_wing_width = 10;
connector_wing_depth = 3.85;
connector_screw_center = 5; // inside wing
connector_contact_width_sep = 15;
connector_contact_height_sep = 7.5;
connector_contact_width = 2.2;
connector_contact_height = 3.9;

switch_depth = 28.0; // including contacts
switch_front_height = 21.25;
switch_front_width = 27.0;
switch_front_depth = 3; // to be verified
switch_contact_depth = 7;
switch_contact_height = 5;
switch_contact_width = 2;
switch_contact_distance = 7;
switch_body_height = 12.1;
switch_body_width = 20.7;
switch_body_depth = switch_depth - switch_front_depth - switch_contact_depth;

m3_nut_height=2.5;
m3_nut_radius=3.4;
m3_nut_dia=m3_nut_radius*2;
m3_bolt_radius=1.8;
m3_bolt_dia=m3_bolt_radius*2;

module nut_trap(wall_thickness) {
	union() {
		rotate([0, 90, 0])
			cylinder(r=m3_nut_radius, h=m3_nut_height, $fn=6, center=true);
		translate([wall_thickness - m3_nut_height, 0, 0])
			rotate([0, 90, 0])
				cylinder(r=m3_bolt_radius, h=wall_thickness, center=true);
	}
}

module power_supply_slot() {
	hull() {
		translate([0,0,power_supply_slot_height/2 - power_supply_slot_dia/2])
			rotate([0,90,0])
				cylinder(h=power_supply_wall_thickness, d=power_supply_slot_dia, center=true, $fn=16);
		translate([0,0,-power_supply_slot_height/2 + power_supply_slot_dia/2])
			rotate([0,90,0])
				cylinder(h=power_supply_wall_thickness, d=power_supply_slot_dia, center=true, $fn=16);
	}
}

module power_supply() {
	union() {
		difference() {
			cube([	power_supply_width,
					power_supply_depth,
					power_supply_height], true);
			translate([0, 
						-power_supply_depth/2 + power_supply_cutout_depth/2, 
						power_supply_height/2 - power_supply_cutout_height/2])
				cube([	power_supply_width - power_supply_wall_thickness*2,
						power_supply_cutout_depth, 
						power_supply_cutout_height],
						true);
			translate([	power_supply_width/2 - power_supply_wall_thickness/2,
							-power_supply_depth/2 + power_supply_wall_thickness + power_supply_slot_depth_offset,
							-power_supply_height/2 + power_supply_slot_height/2 + power_supply_slot_bottom_offset])
				power_supply_slot();
			translate([	-power_supply_width/2 + power_supply_wall_thickness/2,
							-power_supply_depth/2 + power_supply_wall_thickness + power_supply_slot_depth_offset,
							-power_supply_height/2 + power_supply_slot_height/2 + power_supply_slot_bottom_offset])
				power_supply_slot();
		}
		translate([	power_supply_width/2 - power_supply_wall_thickness -
							power_supply_screw_bank_right_offset - power_supply_screw_bank_width/2,
						-power_supply_depth/2 + power_supply_cutout_depth/2,
						-power_supply_height/2 + power_supply_screw_bank_height/2 +
							power_supply_height - power_supply_cutout_height])
			cube([	power_supply_screw_bank_width,
					power_supply_cutout_depth,
					power_supply_screw_bank_height],
					true);
	}
}

module power_connector_shape(height, width, depth, cornerWidth) {
	rotationOffset = sqrt(cornerWidth*cornerWidth+cornerWidth*cornerWidth)/2 - cornerWidth/2;
	widthOffset = width/2 - cornerWidth/2;
	heightOffset = height/2 - cornerWidth/2;
	hull() {
		translate([-widthOffset, 0, heightOffset]) cube([cornerWidth,depth,cornerWidth], true);
		translate([widthOffset, 0, heightOffset]) cube([cornerWidth,depth,cornerWidth], true);
		translate([-widthOffset + rotationOffset, 0, -heightOffset + rotationOffset]) rotate([0,45,0])
			cube([cornerWidth,depth,cornerWidth], true);
		translate([widthOffset - rotationOffset, 0, -heightOffset + rotationOffset]) rotate([0,45,0])
			cube([cornerWidth,depth,cornerWidth], true);
	}
}

module power_connector_wing() {
	difference() {
		hull() {
			translate([-connector_wing_width/2,0,-connector_wing_depth/2])
				linear_extrude(height=connector_wing_depth) 
					polygon(points=[	[0,-connector_front_height/2],
											[0, connector_front_height/2],
											[connector_wing_width, 0]]);
			translate([connector_wing_width/2 - m3_bolt_dia*1.5/2,0,0])
				cylinder(h = connector_wing_depth, d = m3_bolt_dia*1.5, center = true);
		}
	translate([-connector_wing_width/2 + connector_screw_center, 0, 0])
		cylinder(h = connector_wing_depth, d = m3_bolt_dia, center = true);
	}
}

module power_connector_contact() {
	cube([connector_contact_width,connector_depth, connector_contact_height], true);
}

module power_connector() {
	union() {
		difference() {
			union() {
				cube([	connector_front_width, 
						connector_front_depth, 
						connector_front_height], true);
				translate([0, connector_front_depth / 2 + connector_body_depth / 2])
					power_connector_shape(	height = connector_body_height,
													width = connector_body_width,
													depth = connector_body_depth,
													cornerWidth = 5);
				if (connector_has_wings) {
					translate([	connector_wing_width/2 + connector_front_width/2,
									connector_front_depth/2 - connector_wing_depth/2,
									0]) 
						rotate([90,0,0]) power_connector_wing();
					translate([	-connector_wing_width/2 - connector_front_width/2,
									connector_front_depth/2 - connector_wing_depth/2,
									0])
						rotate([90,0,180]) power_connector_wing();
				}
			}
			translate([0,connector_front_depth/2,0])
				power_connector_shape(	height = connector_body_height-4,
												width = connector_body_width-4,
												depth = connector_body_depth,
												cornerWidth = 5);
		}
		translate([	-connector_contact_width_sep/2,
						connector_depth/2 - connector_front_depth/2,
						connector_contact_height_sep/2]) 
			power_connector_contact();
		translate([	connector_contact_width_sep/2,
						connector_depth/2 - connector_front_depth/2,
						connector_contact_height_sep/2]) 
			power_connector_contact();
		translate([	0,
						connector_depth/2 - connector_front_depth/2,
						-connector_contact_height_sep/2]) 
			power_connector_contact();
	}
}

module power_switch() {
	
	union() {
		cube([switch_front_width, switch_front_depth, switch_front_height], true);
		intersection() {
			translate([0,-6/2 - switch_front_depth/2,0])
				cube([switch_front_width, 6, switch_front_height], true);
			translate([-switch_front_width/4,1,0]) rotate([0,0,35])
				cube([switch_body_width/2 - 3, 10, switch_body_height - 3], true);
		}
		translate([0, switch_body_depth/2 + switch_front_depth/2, 0])
			cube([switch_body_width, switch_body_depth, switch_body_height], true);
		translate([0, switch_contact_depth / 2 + switch_body_depth + switch_front_depth/2, 0])
			cube([switch_contact_width, switch_contact_depth, switch_contact_height], true);
		translate([	switch_contact_distance,
						switch_contact_depth / 2 + switch_body_depth + switch_front_depth/2,
						0])
			cube([switch_contact_width, switch_contact_depth, switch_contact_height], true);
	}
}

cover_wall_thickness = 3;
cover_width = power_supply_width - power_supply_wall_thickness*2;
cover_depth = connector_body_depth + connector_contact_depth + power_supply_cutout_depth;
cover_height = power_supply_height;
cover_12V_hole_diameter = 12;
cover_pot_hole_diameter = 6; // also for led
cover_side_extension_depth = 0;

module power_supply_cover() {
	difference() {
		// Main body
		cube([cover_width, cover_depth+cover_side_extension_depth, cover_height], true);
		// Only keep side walls after cutout
		translate([0,cover_depth/2 ,0])
			cube([power_supply_width, cover_side_extension_depth, cover_height], true);
		// Remove inner space
		translate([0,cover_wall_thickness/2,0])
			cube([	cover_width-cover_wall_thickness*2,
					cover_depth+cover_side_extension_depth-cover_wall_thickness,
					cover_height-cover_wall_thickness*2],
					true);
		// Remove bottom section so the cover can fit over the screw terminal
		translate([	0,
						cover_depth/2-power_supply_cutout_depth/2,
						-power_supply_height/2+(power_supply_height - power_supply_cutout_height)/2])
			cube([	power_supply_width - power_supply_wall_thickness*2,
					power_supply_cutout_depth,
					power_supply_height - power_supply_cutout_height],
					true);
		// Hole for 12V cable
		translate([	-cover_width/4,
						-cover_depth/2-cover_side_extension_depth/2+cover_wall_thickness/2,
						cover_height/2 - connector_front_height/2 - cover_wall_thickness])
			rotate([90,0,0])
				cylinder(h=cover_wall_thickness, d=cover_12V_hole_diameter, center=true);
		// Hole for pot
		translate([	-power_supply_width_pot_offset,
						cover_depth/2 - cover_side_extension_depth/2 - power_supply_depth_pot_offset,
						cover_height/2-cover_wall_thickness/2])
			cylinder(h=cover_wall_thickness, d=cover_pot_hole_diameter, center=true);
		// Hole for led
		translate([	-power_supply_width_led_offset,
						cover_depth/2 - cover_side_extension_depth/2 - power_supply_depth_pot_offset,
						cover_height/2-cover_wall_thickness/2])
			cylinder(h=cover_wall_thickness, d=cover_pot_hole_diameter, center=true);
		// Hole for power connector
		translate([	cover_width/2 - connector_wing_width - connector_front_width/2 - cover_wall_thickness,
						-cover_depth/2 - cover_side_extension_depth/2 + cover_wall_thickness/2,
						cover_height/2 - connector_front_height/2 - cover_wall_thickness])
				power_connector_shape(	height = connector_body_height,
												width = connector_body_width,
												depth = cover_wall_thickness,
												cornerWidth = 5);
		// Nut trap for screw power connector 1
		translate([	cover_width/2 - connector_wing_width - cover_wall_thickness + connector_screw_center,
						-cover_depth/2 - cover_side_extension_depth/2 + cover_wall_thickness/2 + 1,
						cover_height/2 - connector_front_height/2 - cover_wall_thickness])
			rotate([90,0,-90])
				nut_trap(cover_wall_thickness + 1);
		// Nut trap for screw power connector 2
		translate([	cover_width/2 - connector_wing_width - cover_wall_thickness -
							connector_screw_center - connector_front_width,
						-cover_depth/2 - cover_side_extension_depth/2 + cover_wall_thickness/2 + 1,
						cover_height/2 - connector_front_height/2 - cover_wall_thickness])
			rotate([90,0,-90])
				nut_trap(cover_wall_thickness + 1);
		// Hole for switch
		translate([	0,
				-cover_depth/2 - cover_side_extension_depth/2 + switch_front_height/2 + 1.5*cover_wall_thickness,
				cover_height/2 - cover_wall_thickness/2]) 
			cube([switch_body_width, switch_body_depth, cover_wall_thickness], true);
		// Nut trap 1
		translate([	cover_width/2 - m3_nut_height/2,
						cover_depth/2 - power_supply_cutout_depth+power_supply_slot_depth_offset+m3_nut_radius/2,
						-power_supply_height/2 + power_supply_slot_height/2 + 
							power_supply_slot_bottom_offset  + power_supply_cutout_height/6])
			rotate([0,0,180])
				nut_trap(cover_wall_thickness);
		// Nut trap 2
		translate([	cover_width/2 - m3_nut_height/2,
						cover_depth/2 - power_supply_cutout_depth+power_supply_slot_depth_offset+m3_nut_radius/2,
						-power_supply_height/2 + power_supply_slot_height/2 + 
							power_supply_slot_bottom_offset - power_supply_cutout_height/6])
			rotate([0,0,180])
				nut_trap(cover_wall_thickness);
		// Nut trap 3
		translate([	-cover_width/2 + m3_nut_height/2,
						cover_depth/2 - power_supply_cutout_depth+power_supply_slot_depth_offset+m3_nut_radius/2,
						-power_supply_height/2 + power_supply_slot_height/2 + 
							power_supply_slot_bottom_offset  + power_supply_cutout_height/6])
				nut_trap(cover_wall_thickness);
		// Nut trap 4
		translate([	-cover_width/2 + m3_nut_height/2,
						cover_depth/2 - power_supply_cutout_depth+power_supply_slot_depth_offset+m3_nut_radius/2,
						-power_supply_height/2 + power_supply_slot_height/2 + 
							power_supply_slot_bottom_offset - power_supply_cutout_height/6])
				nut_trap(cover_wall_thickness);
	}
}

if (show_assembly) {
	translate([	0, 
					power_supply_depth/2 + cover_depth/2 - cover_side_extension_depth/2 -
						power_supply_cutout_depth,
					0])
		power_supply();
	*translate([	cover_width/2 - connector_wing_width - connector_front_width/2 - cover_wall_thickness,
					-cover_depth/2 - cover_side_extension_depth/2 - connector_front_depth/2,
					cover_height/2 - connector_front_height/2 - cover_wall_thickness])
		power_connector();
	*translate([	0,
					-cover_depth/2 - cover_side_extension_depth/2 +
						 switch_front_height/2 + 1.5*cover_wall_thickness,
					cover_height/2 + switch_front_depth/2]) 
		rotate([-90,0,0]) power_switch();
	%power_supply_cover();
} else {
	rotate([90,0,0]) power_supply_cover();
}
