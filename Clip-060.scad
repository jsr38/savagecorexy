//Buffer-Local Properties for jEdit, www.jedit.org
//:indentSize=4:tabSize=4:collapseFolds=true:folding=explicit:mode=c:

//
// (c) Andreas Thorn (andreas.thorn@gmail.com)
//	Thingiverse: 
//	
// Licence: Attribution - Share Alike - Creative Commons
//


//{{{ Info, Changelog
/*************************************************************************************************
Parametric cable clip/holder for mounting cables to aluminum extrusion.
Parametry tested for use with CAT5 network cable and 6mm slot aluminum extrusion like Makerslide.
Also tested to work well with plastic cable collectors/spirals with dimensions similar to CAT5.
Parametry should allow for other dimensions too.

Changelog;
050	Initial work. Cable holder and base. No mount. Single and dual assemblies.
051	WIP (Work in progress). More static options are now calculated from more vital options.
052	WIP. Profile mount with slot. Angle of wall opening optional.
053	WIP. Tripple assembly added.
054	WIP. Rounded slot between the hooks to prevent breakage. Translations for demo.
055	WIP. Console echos some interesting dimensions. cableholder_wallopening expands.
056	WIP. Degenerate triangle in KISSlicer. Changing back to non expanding cableholder_wallopening.
	Doesn't help. Removed the wallopening completely. Doesn't help. ?!!!
057	WIP. Error generating code restored but fixed. Use Flush Caches to get rid of persistent errors in OpenSCAD! Degenerate triangle error.
058 WIP. Stopped using polyhole since its' flat edges introduced a degenerate triangle.
059	WIP. Removed extra 0.5 distance for the rounded side of mountslot_hook to make the mount flex some.
	Added similar distance by increasing cableholder_baseheight from 0.2 to 1.0.
	Testprinted. Very tight fit in Makerslide. At 10mm height they have to be removed with pliers.
060	More hook related constants/variables parametric relations to others.
	Testprinted with KISSlicer. Cleaned up. Ready for public release.
**************************************************************************************************/
//}}}
//{{{ Variables and constants
shim = 0.1;								// used overlap meshes/cutouts

cableholder_idiam = 5.2;						// cable diameter
cableholder_height = 5;							// height of cable holder
cableholder_segments = 30;						// segments/resolution $fn of the cylindrical parts
cableholder_baseheight = 1.0;					// height of the square base of the cable holder
mountslot_width = 5.9;							// aluminium profile slot width
mountslot_thickness = 2;						// aluminium profile slot edge thickness
mountslot_height = cableholder_height;			// height of profile mount. <= cableholder_height is supported
mountslot_hookwidthmax = 1.2*mountslot_width;		// max width of locking hooks on profile mount
mountslot_hookwidthmin = 0.6*mountslot_width;		// min width of locking hooks on profile mount
mountslot_hooklength = 0.5*mountslot_hookwidthmax;	// 4	// length of locking hooks on profile mount
mountslot_hookslotwidth = mountslot_width/1.7;		// 3	// width of slot between locking hooks on profile mount

cableholder_wall = cableholder_idiam / 4;			// wall thickness
cableholder_wallopeningwidthmin = 1;				// opening in wall for cable insertion/removal
cableholder_wallopeningwidthmax = 1.1*cableholder_idiam;	// opening in wall for cable insertion/removal
cableholder_wallopeningangle = 90;				// angle of rotation of opening in wall. recommend 0 or 90.
cableholder_odiam = cableholder_idiam + (2*cableholder_wall);
//}}}

//{{{ Module polyhole
// http://hydraraptor.blogspot.se/2011/02/polyholes.html
module polyhole(h, d) {
    n = max(round(2 * d),3);
    rotate([0,0,180])
        cylinder(h = h, r = (d / 2) / cos (180 / n), $fn = n);
}
//}}}
//{{{ Module cylinda
module cylinda(diam=1,height=1,fn=60,polyhole=0)
{
	if (polyhole==1)
	{
		polyhole(h=height,d=diam);
	} else {
		cylinder(r=diam/2,h=height,$fn=fn);
	}
}
//}}}

//{{{ Module part_cableholder
module part_cableholder()
{
	difference()
	{
		union()
		{
			hull()
			{
				// cable holder
				translate([0,cableholder_baseheight,0])
				translate([0,0,0]) cylinda(cableholder_odiam,cableholder_height,cableholder_segments,0);
				// cable holder base
				translate([-cableholder_odiam/2,-cableholder_odiam/2,0]) cube([cableholder_odiam,cableholder_baseheight,cableholder_height]);
			}
		}
		// cable holder hole
		translate([0,cableholder_baseheight,0])
		translate([0,0,-shim]) cylinda(cableholder_idiam,cableholder_height+(2*shim),cableholder_segments,0);
		// opening in wall
		translate([0,cableholder_baseheight,0])
		hull()
		{
			rotate([0,0,cableholder_wallopeningangle]) translate([-0.1/2,-cableholder_wallopeningwidthmin/2,-shim]) cube([0.1,cableholder_wallopeningwidthmin,cableholder_height+(2*shim)]);
			rotate([0,0,cableholder_wallopeningangle]) translate([cableholder_odiam/2+shim,-cableholder_wallopeningwidthmax/2,-shim]) cube([0.1,cableholder_wallopeningwidthmax,cableholder_height+(2*shim)]);
		}
	}
}
//}}}
//{{{ Module part_profilemount
module part_profilemount()
{
	translate([0,0,(cableholder_height-mountslot_height)/2])
	difference()
	{
		union()
		{
			translate([-mountslot_width/2,0,0]) cube([mountslot_width,mountslot_thickness,mountslot_height]);
			hull()
			{
				translate([-mountslot_hookwidthmax/2,mountslot_thickness,0]) cube([mountslot_hookwidthmax,0.1,mountslot_height]);
				translate([-mountslot_hookwidthmin/2,mountslot_thickness+mountslot_hooklength,0]) cube([mountslot_hookwidthmin,0.1,mountslot_height]);
			}
		}
		translate([-mountslot_hookslotwidth/2,(mountslot_hookslotwidth/2)+0,-shim]) cube([mountslot_hookslotwidth,mountslot_thickness+0.1+0.1+mountslot_hooklength+shim,mountslot_height+(2*shim)]);
		translate([0,(mountslot_hookslotwidth/2)+0,-shim]) cylinda(mountslot_hookslotwidth,cableholder_height+(2*shim),cableholder_segments,0);
	}
}
//}}}


//-----------------------------------------------------------------------------
//{{{ Assemblies
// only the mount. for debugging purposes
translate([-20,20,0]) mirror([0,1,0]) color([0.5,1.0,0.5,1.0]) part_profilemount();

// only the cable holder. for debugging purposes
translate([0,20,0]) mirror([0,0,0]) color([0.5,1.0,0.5,1.0]) part_cableholder();

// cable holder single assembly
translate([-20,0,0])
{
	translate([0,cableholder_odiam/2,0]) mirror([0,0,0]) part_cableholder();
	translate([0,0,0]) mirror([0,1,0]) part_profilemount();
}

// cable holder dual assembly
translate([0,0,0])
{
	translate([-(cableholder_odiam/2)+shim,cableholder_odiam/2,0]) mirror([1,0,0]) part_cableholder();
	translate([(cableholder_odiam/2)-shim,cableholder_odiam/2,0]) mirror([0,0,0]) part_cableholder();
	translate([1*(cableholder_odiam/2)-shim,0,0]) mirror([0,1,0]) part_profilemount();
}
// cable holder tripple assembly. here with non-centered mount suitable for makeslide.
translate([25,0,0])
{
	translate([-2*(cableholder_odiam/2)+shim,cableholder_odiam/2,0]) mirror([1,0,0]) part_cableholder();
	translate([0,cableholder_odiam/2,0]) mirror([0,0,0]) part_cableholder();
	translate([2*(cableholder_odiam/2)-shim,cableholder_odiam/2,0]) mirror([0,0,0]) part_cableholder();
	translate([2*(cableholder_odiam/2)-shim,0,0]) mirror([0,1,0]) part_profilemount();
}
//}}}

// some information
echo(str("cableholder_wall = ", cableholder_wall));
echo(str("total length = ", mountslot_thickness+mountslot_hooklength+cableholder_odiam));