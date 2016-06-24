//
//Mount for E3D hotend clone with mount for 18mm diameter proximity sensor
// this is designed to be bolted in place of the stock folgertech extruder,
// or any extruder mounted with holes the same width as Nema17 motor screws
//    this is part of the conversion to a bowden setup
// Designed by Lee Buell
// version1.0 December 30, 2015
// GPL v3.0
//  released under Creative Commons - Attribution - Share Alike licence (CC BY-SA)
//////////////////////////////////////////////////////////////////////////////////////
// it uses two libraries from the mendel90 design, available from here:
//
// https://github.com/T3P3/Mendel90/tree/LaserCut/scad
// teardrops.scad
// utils.scad
//
//
// this was designed for the E3D clone hot ends, by changing the JHeadDiameters below, it might work with a genuine E3D hot end
//  Explanation of JHeadDiameters numbers:
//    the first is the width of the narrow part of the mount (top)
//    the second is the  width of the wide part of the mount (top)
//    the third is the width of the bottom cooling fin area, I don't have a genuine E3D, but I believe this third number is the one to change



JHeadDiameters = [12.7, 16, 25];
JHeadDimensions = [3.7, 9.1, 12.3, 18.3, 50.1];

FanMountingHoleWidth=32; //32 for a 40mm fan
FlangeThickness=8;  // Thickness of mounting flange and Hot end mounting plate
HotendHeight=25;  // height of Hot End mount on mounting flange
FanWidth=40;
FanMountPitch = 30.0; // Mounting hole pitch for ducted fan
FlangeExtension=27.0;   //Length beyond fan with for hot end to mount
FlangeLength=FanWidth+FlangeExtension;// - 5.0;  //Total flange length
HotEndHeatSinkWidth=25; //width of heat sink, ?? for E3D  25 for chinese E3D clone
HotEndMountingThinArea=12.5;  //Thin band on the top of the HE
HotEndMountingWideArea=30.5;  //Wide bands on the top of the HE
HotEndMountingThinAreaHeight=5;  //Height of thin band
HotEndMountingWideAreaHeight=13;  //Height of wide band
ProxSensorDiameter=18.5;  //Diameter of proximity sensor
ProxSensorNutDiam=28.5;   //Diameter of proximity sensor nuts
ProxSensorLockWasherDiam=31;   //Diameter of proximity sensor LockWashers
ProxSensorDiameterMountFlangeWidth=ProxSensorNutDiam+7.5;
DistanceBetweenHE_Sensor=2;  //distand between the hot end and the proximity sensor
MountingHoleDistance=sqrt((FanMountingHoleWidth/2*FanMountingHoleWidth/2)*2);
CornerRadius=4;

CarriageMountHolePitch = 20;


print_clearance=0.1; //additional clearance between two printed objects

$fn=30;

!rotate([-90,0,0])
translate([25,-FlangeThickness/2,30])
difference(){
CompleteHotEndMount();
translate([0,-(ProxSensorDiameterMountFlangeWidth+DistanceBetweenHE_Sensor+HotEndHeatSinkWidth/2+5)-50,0])
cube([100,100,100], center=true);
}
difference(){
rotate([-90,0,90])
translate([25,(ProxSensorDiameterMountFlangeWidth+DistanceBetweenHE_Sensor+HotEndHeatSinkWidth/2+5),35])
CompleteHotEndMount();
translate([0,30,-50])
cube([120,100,100], center=true);
}


module CompleteHotEndMount(){
 difference(){
    union(){
      //Flange that mounts to x-carriage
      //mounting_flange();
	  
	   //Flange to mount Hot end
      translate([0,-FlangeLength / 2.0,-HotendHeight])
      rounded_rectangle([FanWidth + 20.0,FlangeLength,FlangeThickness+2],CornerRadius);

      }  //union
	  
      // Cavities
      // hole for proximity sensor
      //translate([0,-20,-40])
      //ProxSensorHole();
      
      
	  // hole for jhead mount
	  echo(ProxSensorDiameterMountFlangeWidth+DistanceBetweenHE_Sensor+HotEndHeatSinkWidth/2+5);
      translate([0,-(ProxSensorDiameterMountFlangeWidth+DistanceBetweenHE_Sensor+HotEndHeatSinkWidth/2+5),-HotendHeight-6])	  
      rotate([180,0,0])
      JHead(JHeadDiameters, JHeadDimensions);
	  
      // Mount holes for carriage
      translate([( - CarriageMountHolePitch) / 2.0,-10.0,-HotendHeight]) cylinder(r= 2.55, h = FlangeThickness + 4.0, center = true);
      translate([( CarriageMountHolePitch) / 2.0,-10.0,-HotendHeight]) cylinder(r= 2.55, h = FlangeThickness + 4.0, center = true);
      
	  // holes for retainer cap	 
	  translate([12,-(FlangeLength+1),-25])
	  rotate([90,0,180])
	 Locknut_and_screwhole(Screwlength=16,DepthOfNut=22);
	 translate([-12,-(FlangeLength+1),-25])
	  rotate([90,0,180])
	  Locknut_and_screwhole(Screwlength=16,DepthOfNut=22);
	  
      // Holes for fan mount
      translate([-47,-FlangeLength + 8.0,-25]) rotate([90,0,90]) Locknut_and_screwhole(Screwlength=16,DepthOfNut=22);
      translate([-47,-FlangeLength + 8.0 + FanMountPitch,-25]) rotate([90,0,90]) Locknut_and_screwhole(Screwlength=16,DepthOfNut=22);
      
  } //difference
}  //module

module Locknut_and_screwhole(Screwlength=16,DepthOfNut=15){
//hole for m3 bolt followed by hex hole for m3 locknut
//hole for m3 bolt - with tight fit

nutheight=4.6;  // height of locknut as it sits flat on a table  // 4.5 when printed so nut is oriented flat, 4.5 was tight due to a stray hanging part of filament
LocknutDiamater=6.9;  //  Diameter of locknut with extra clearance added so it drops in but still grips the nut without slipping  //7.1 slipped - too large
screwheaddiamater=7;  //diamter of the head of the screw
ScrewheadHoleDiam=screwheaddiamater+.3; // remember the added value on the end witll be cut in half since since openscad uses radius measurements

LengthBeforeNut=DepthOfNut;
LengthAfterNut=3;

TotalNutLength=DepthOfNut+nutheight+LengthAfterNut;
RecessedHeadDepth=(TotalNutLength-1.5)-Screwlength;

//recessed hole for m3 screw
translate([0,0,-1])
cylinder(h=RecessedHeadDepth+1,r1=screwheaddiamater/2,r2=screwheaddiamater/2, center = false, $fn=16);

//hole for m3 screw
translate([0,0,0])
cylinder(h=TotalNutLength,r1=3/2+.1,r2=3/2+.1, center = false, $fn=16);

// hole for m3 locknut
translate([0,0,DepthOfNut])
rotate([0,0,30])    //rotate the flat sides of the hex nut
cylinder(h=nutheight,r1=LocknutDiamater/2,r2=LocknutDiamater/2, center = false, $fn=6);

//hole to drop nut into
translate([-LocknutDiamater/2+.475,-15,DepthOfNut])
rotate([0,0,0])   cube([(sqrt(3)*(LocknutDiamater/2)),15,nutheight]);
}  //module

module JHead(diameters = [12, 16, 25], dimensions = [3.7, 9.3, 12.3, 18.3, 50.1]) {
    color("Red") {
      // Top of JHead
      translate([0,0,-dimensions[0]])
        cylinder(d=diameters[1], h=dimensions[0]);
      translate([0,0,-dimensions[1]-0.01])
       cylinder(d=diameters[0], h=dimensions[1]-dimensions[0]+0.5);
      translate([0,0,-dimensions[2]])
        cylinder(d=diameters[1], h=dimensions[2]-dimensions[1]+.3);
      translate([0,0,-dimensions[3]])
        cylinder(d=9, h=dimensions[3]-dimensions[2]);
      translate([0,0,-dimensions[4]]) {
        // Radiator Volume
        cylinder(d=diameters[2], h=dimensions[4]-dimensions[3]);
        translate([0,0,-10]) {
          // Throat
          cylinder(d=6, h=10);
          // Heating Block
          translate([0,5,0])
            cube([20,20,10], center=true);
          // Nozzle
          translate([0,0,-12])
            cylinder(d1=1, d2=5, h=3);
          translate([0,0,-9])
            cylinder(d=10, h=5, $fn=6);
        }
      }
    }
  }

module HotEndMountHole(){
      //thin par of Hot end neck
     cylinder(h=20, r=HotEndMountingThinArea/2, $fn=20);
     // top wide part of Hot end neck
     translate([0,0,-15])
     cylinder(h=20, r=HotEndMountingWideArea/2, $fn=20);
     // bottom wide part of Hot end neck
     translate([0,0,10])
     cylinder(h=10, r=HotEndMountingWideArea/2, $fn=20);

}  // module

module ProxSensorHole(){
  //round hole for sensor
  cylinder(h=80, r=ProxSensorDiameter/2, $fn=20);
  //hex hole for nut
  translate([0,0,-2]) rotate([0,0,30])
  cylinder(h=40, r=ProxSensorNutDiam/2, $fn=6);
}  // module

module mounting_flange(){
  difference(){
      union(){
        // vertical part of flange
        translate([0,0,-5]) rotate([90,0,0])
        rounded_rectangle([FanWidth+10,FanWidth+10,FlangeThickness],CornerRadius);
        // horizontal mount for the proximity sensor
        hull(){
          translate([0,0,-9])
          rounded_rectangle([FanWidth-8,8,27],CornerRadius);
          translate([0,-20,-20.5])
          cylinder(h=25, r=(ProxSensorDiameterMountFlangeWidth)/2, $fn=20);
           } //hull
      } //union
      //holes mounting to X-carriage
        translate([0,30,0]) rotate([90,0,0])
             for ( i = [0:3] )  // 0:3 =4 mounting holes in flange
             {
          rotate( i*360/4+45, [0, 0, 1])
          translate([MountingHoleDistance,0,0])
          cylinder(h=60, r=3.9/2, $fn=20);
             }  //for loop
      // cavities for nuts
        translate([0,30,0]) rotate([90,0,0])
             for ( i = [0:3] )  // 0:3 =4 mounting holes in flange
               {
            rotate( i*360/4+45, [0, 0, 1])
            translate([MountingHoleDistance,0,30])
            rotate([0, 0, 30])
            cylinder(h=40, r=7.1/2, $fn=6);  //was 7.2 was too loose
                }  //for loop
      // blind holes near nut cavities
          translate([0,30,0]) rotate([90,0,0])
                     for ( i = [0:3] )  // 0:3 =4 mounting holes in flange
                       {
                    rotate( i*360/4+45, [0, 0, 1])
                    translate([MountingHoleDistance,0,35])
                  //  rotate([0, 0, 45])
                    cylinder(h=40, r=8/2, $fn=20);
                        }  //for loop
  } //difference
}  //module


// From:
// https://github.com/T3P3/Mendel90/tree/LaserCut/scad
// utils.scad
module rounded_square(w, h, r)
{
    union() {
        square([w - 2 * r, h], center = true);
        square([w, h - 2 * r], center = true);
        for(x = [-w/2 + r, w/2 - r])
            for(y = [-h/2 + r, h/2 - r])
                translate([x, y])
                    circle(r = r);
    }
}

// From:
// https://github.com/T3P3/Mendel90/tree/LaserCut/scad
// utils.scad
module rounded_rectangle(size, r, center = true)
{
    w = size[0];
    h = size[1];
    linear_extrude(height = size[2], center = center)
        rounded_square(size[0], size[1], r);
}
