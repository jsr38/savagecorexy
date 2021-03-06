use <kjn-parts-library.scad>;
use <misumi-parts-library.scad>;
use <bed.scad>;
use <XGantry.scad>
use <motor-bracket.scad>
use <x-carriage.scad>
use <y-carriage.scad>
use <sg-spool.scad>
use <idler-corner.scad>
//use <scissor-lift.scad>
use <z-leadscrew-gantry.scad>

extrusion= 40; // extrusion 4040
//sides= 1000; // side length of cube in mm

// Bear in mind, x and y are transposed with respect to
// the reference corexy documentation here
// http://www.corexy.com/theory.html

side_x = 1500;
side_y = 500;
side_z = 500;

sep_x = side_x/2 + extrusion/2; // separation of each side centre to centre
sep_y = side_y/2 + extrusion/2; // separation of each side centre to centre
sep_z = side_z/2 + extrusion/2; // separation of each side centre to centre


//sep= sides;
height= side_z-extrusion/2;
bracket_side = 30;
bheight= side_z - bracket_side;

module gantry(xpos=0) {
        translate([0,0,-2]) Xgantry(xpos);
        translate([sep_y + (extrusion / 2.0),0,- (extrusion / 2.0)]) rotate([0,0,90]) Ycarriage_with_wheels();
        translate([-sep_y - (extrusion / 2.0),0,- (extrusion / 2.0)]) rotate([0,0,-90]) Ycarriage_with_wheels();

}


// bottom
raised= 30;
translate([-sep_x,-side_y / 2.0,extrusion/2+raised]) itm4040(side_y);
translate([ sep_x,-side_y / 2.0,extrusion/2+raised]) itm4040(side_y);
translate([side_x / 2.0, sep_y,extrusion/2+raised]) rotate([0,0,90]) itm4040(side_x);
translate([side_x / 2.0,-sep_y,extrusion/2+raised]) rotate([0,0,90]) itm4040(side_x);

// verticals
translate([-sep_x,-sep_y,0]) rotate([90,0,0]) itm4040(side_z);
translate([ sep_x,-sep_y,0]) rotate([90,0,0]) itm4040(side_z);
translate([-sep_x, sep_y,0]) rotate([90,0,0]) itm4040(side_z);
translate([ sep_x, sep_y,0]) rotate([90,0,0]) itm4040(side_z);

// top
translate([-sep_x,-side_y / 2.0,height - raised]) itm4040(side_y);
translate([ sep_x,-side_y / 2.0,height - raised]) itm4040(side_y);
translate([side_x / 2.0, sep_y,height - raised]) rotate([0,0,90]) itm4040(side_x);
translate([side_x / 2.0,-sep_y,height - raised]) rotate([0,0,90]) itm4040(side_x);

// brackets inside bottom corner lr
translate([ side_x / 2.0, -sep_y, raised]) rotate([0,180, 90]) hblfsn5();
translate([-side_x / 2.0, -sep_y, raised]) rotate([0,180,-90]) hblfsn5();
translate([ side_x / 2.0,  sep_y, raised]) rotate([0,180, 90]) hblfsn5();
translate([-side_x / 2.0,  sep_y, raised]) rotate([0,180,-90]) hblfsn5();

// brackets inside bottom corner bf
translate([ sep_x, -side_y / 2.0, raised]) rotate([180,0,180]) hblfsn5();
translate([-sep_x, -side_y / 2.0, raised]) rotate([180,0,180]) hblfsn5();
translate([ sep_x,  side_y / 2.0, raised]) rotate([180,0,  0]) hblfsn5();
translate([-sep_x,  side_y / 2.0, raised]) rotate([180,0,  0]) hblfsn5();

// brackets bottom corner
translate([ side_x / 2.0, -side_y / 2.0, extrusion/2+raised]) rotate([0,90, 90]) hblfsn5();
translate([-side_x / 2.0, -side_y / 2.0, extrusion/2+raised]) rotate([0,90,  0]) hblfsn5();
translate([ side_x / 2.0,  side_y / 2.0, extrusion/2+raised]) rotate([0,90,180]) hblfsn5();
translate([-side_x / 2.0,  side_y / 2.0, extrusion/2+raised]) rotate([0,90,-90]) hblfsn5();

// brackets top corner
translate([ side_x / 2.0, -side_y / 2.0, height-raised]) rotate([0,90, 90]) hblfsn5();
translate([-side_x / 2.0, -side_y / 2.0, height-raised]) rotate([0,90,  0]) hblfsn5();
translate([ side_x / 2.0,  side_y / 2.0, height-raised]) rotate([0,90,180]) hblfsn5();
translate([-side_x / 2.0,  side_y / 2.0, height-raised]) rotate([0,90,-90]) hblfsn5();

// brackets inside top corner lr
translate([ side_x / 2.0, -sep_y, bheight]) rotate([0,0, 90]) hblfsn5();
translate([-side_x / 2.0, -sep_y, bheight]) rotate([0,0,-90]) hblfsn5();
translate([ side_x / 2.0,  sep_y, bheight]) rotate([0,0, 90]) hblfsn5();
translate([-side_x / 2.0,  sep_y, bheight]) rotate([0,0,-90]) hblfsn5();

// brackets inside top corner bf
translate([ sep_x, -side_y / 2.0, bheight]) rotate([0,0,  0]) hblfsn5();
translate([-sep_x, -side_y / 2.0, bheight]) rotate([0,0,  0]) hblfsn5();
translate([ sep_x,  side_y / 2.0, bheight]) rotate([0,0,180]) hblfsn5();
translate([-sep_x,  side_y / 2.0, bheight]) rotate([0,0,180]) hblfsn5();

// Base
//translate([0,0,raised+10/2+20]) color("white") cube([520,520, 10], center= true);

///////////////////// end frame ///////////////////////

// Bed
//bedh= 400; //top
//bedh= 138; // bottom
bedh= 250;
if(0) {
	rotate([0, 0, 90])  translate([0,0, raised+10+bedh]) bed_assembly(1,0,0);
	//translate([50,50,raised+10]) rotate([0,0,45]) scissor_lift(bedh);
}

// X gantry
if(1) {
	rotate([0, 0, 90]) {
		translate([0,0,height+extrusion/2-raised]) gantry();
		translate([0,-get_xgantry_width()/2-10,height+extrusion/2-raised+30]) Xcarriage_with_wheels();
	}

}


// Motors
mh = height - 10;
if(1) {
	translate([side_x/2+extrusion,-side_y / 2.0 - extrusion,mh+10]) rotate([180,0,0]) motor_bracket(1);
	translate([side_x/2+extrusion,side_y / 2.0 + extrusion,mh+10]) rotate([180,0,0]) motor_bracket(0);

	translate([side_x / 2.0 + extrusion + 32, side_y / 2.0 + extrusion-8, mh + 10]) spool();
	translate([(side_x / 2.0 + extrusion+32), -side_y / 2.0 -extrusion+8, mh + 10]) spool();
}

ih = height + 20;
if(1) {
	//corner idlers
	translate([-sep_x, -sep_y, ih]) rotate([180,0, 90]) idler_mount();
	translate([ sep_x, -sep_y, ih]) rotate([180,0,180]) idler_mount();
}

// Z gantry, cantilever
zgantry_length= 500-60;
zgantry_pos= 30;
cantilever1_length= 1450; // tan(45)*(sides/2-(zgantry_pos+20+5))+10;
echo(str("cantilever1_length=", cantilever1_length));
ght= raised+10+bedh;

if(1) {
	translate([side_x / 2.0 + 60, zgantry_pos, 30])  rotate([90,0,-90]) hfs2040(zgantry_length);
	translate([-cantilever1_length/2+50, zgantry_pos-20-10, ght])  rotate([0,0,-90]) itm4040(cantilever1_length);
	//translate([sides/2-cantilever1_length+40, zgantry_pos+35, ght])  rotate([0,90,0]) hbl45ts5();
	translate([side_x / 2.0 + 60, zgantry_pos, ght]) rotate([0, 0, -90])   Zcarriage_with_wheels();
	translate([230+60, zgantry_pos, 50]) rotate([0, 90, 90])  actuator();

	// vslot support gantry
	translate([-side_x / 2.0 - 40, 0,   0])  rotate([90,0,-90]) hfs2040(500);
	translate([-side_x / 2.0,      0, ght])  rotate([0,90,  0]) vslot_mini_carriage();

	// cross support
	translate([0, 10, ght])  rotate([0,0,0]) itm4040(150);
}

module vslot_mini_carriage() {
	translate([-175, -40, 0]) {
		color("black") import("VSLOT_Mini_V_Plate.stl");
	}
}
