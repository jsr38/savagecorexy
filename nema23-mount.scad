$fn = 100;

thick = 8;

rotate([0,-90,0])

union(){
	translate([0,0,5])
	difference(){
		translate([0,0,0]) cube([thick,65,65]);
		translate([-1,32.5,32.5]) rotate([0,90,0]) cylinder(r=19.05,h=thick+ 2);
		translate([-1,8.95,8.95]) rotate([0,90,0]) cylinder(r=2.04,h=thick+ 2);
		translate([-1,56.05,8.95]) rotate([0,90,0]) cylinder(r=2.04,h=thick+ 2);
		translate([-1,8.95,56.05]) rotate([0,90,0]) cylinder(r=2.04,h=thick+ 2);
		translate([-1,56.05,56.05]) rotate([0,90,0]) cylinder(r=2.04,h=thick+ 2);
	}

	difference(){
		translate([0,0,0]) cube([65,65,thick]);
		translate([25.4,32.5,-1]) cylinder(r=3.175, h=thick+2);
		translate([50.8,32.5,-1]) cylinder(r=3.175, h=thick+2);

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

