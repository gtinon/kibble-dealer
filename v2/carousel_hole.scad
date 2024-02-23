include <params.scad>


// for tests
//cut([0,1,0])
hole_shape(reservoirR, 10, 35);


module hole_shape(radius, inner_radius, angle, thickness=10) {
    rotate([0, 0, -angle/2])
    difference() {
        cylinder(thickness, r=radius, center=false, $fn=48);
        
        translate([0, 0, -1])
        cylinder(thickness*2, r=inner_radius, center=false, $fn=48);
        
        // remove bottom half
        translate([-radius*2, -radius*2, -1])
        cube([radius*4, radius*2, thickness*2]);
        
        // remove left half
        translate([-radius*2, -radius*2, -1])
        cube([radius*2, radius*4, thickness*2]);

        // remove the rest
        rotate([0, 0, angle])
        translate([0, 0, -1])
        cube([radius*2, radius*2, thickness*2]);
    }
}