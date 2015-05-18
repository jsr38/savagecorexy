
module itm4040(h) {
	
	color("silver") {
		rotate([-90,0,0]) translate([-20,-20,0]) linear_extrude(height=h)  import("kjn/extrusion.dxf");
	}
}
