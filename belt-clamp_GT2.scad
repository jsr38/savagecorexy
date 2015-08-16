// PRUSA Mendel  
// Belt clamp
// GNU GPL v3
// Josef Průša
// josefprusa@me.com
// prusadjs.cz
// http://www.reprap.org/wiki/Prusa_Mendel
// http://github.com/prusajr/PrusaMendel
//
// modified by neurofun

include <configuration.scad>
use <MCAD/polyholes.scad>

module beltclamp(){

m3_diameter = 3.4;

clamp_height = 3;
clamp_width = 10;
clamp_length = 18;		// distance between the center of the 2 holes
belt_pitch = 2;
belt_width = 10;
tooth_width = 1.3;
tooth_heigth = .75;
offset = belt_pitch/4;
// uncomment next line for a symetric clamp
//offset = 0;

	difference(){
		// basic shape
		union(0){
			translate(v = [0,0,clamp_height/2]) cube([clamp_length,clamp_width,clamp_height], center=true);
			translate(v = [-clamp_length/2, 0, 0]) cylinder(r=clamp_width/2,h=clamp_height);
			translate(v = [clamp_length/2, 0, 0]) cylinder(r=clamp_width/2,h=clamp_height);
			}
		// screw holes
		translate(v = [-clamp_length/2, 0, 0])polyhole(m3_diameter, clamp_height+2);
		translate(v = [clamp_length/2, 0, 0]) polyhole(m3_diameter, clamp_height+2);
		// belt grip
		translate(v = [0,offset,clamp_height-tooth_heigth])
		for ( i = [round(-clamp_width/belt_pitch/2) : round(clamp_width/belt_pitch/2)]){
			translate(v = [0,belt_pitch*i,tooth_heigth])cube(size = [belt_width, tooth_width, tooth_heigth*2], center = true);
		}
	}

}

beltclamp();