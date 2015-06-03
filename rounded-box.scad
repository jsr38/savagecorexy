
use_minkowski = true;
cylinder_faces = 100;

%rounded_box(10,10,10, 2);
cylinder(r = 2, h = 1);

module rounded_box(length, width, height, r) {

    if (use_minkowski) {
        
        minkowski() {

            cylinder(r = r, h = 1);

            cube(size=[ length - (r * 2.0),
                        width - (r * 2.0),
                        height - 1 ], center = false);

        }
        
    } else {
        
        hull() {
            translate([r,r,0]) cylinder(r = r, h = height, $fn = cylinder_faces);
            translate([length-r,r,0]) cylinder(r = r, h = height, $fn = cylinder_faces);
            translate([length-r,width-r,0]) cylinder(r = r, h = height, $fn = cylinder_faces);
            translate([r,width-r,0]) cylinder(r = r, h = height, $fn = cylinder_faces);
        }
    }

}