include <params.scad>
include <../utils/utils.scad>

use <../utils/motor.scad>
use <carousel_hole.scad>

// for tests
//cut([0,1,0])
reservoir();

holeInnerRadius = reservoirR*0.4;
spacerR = reservoirR*0.3;

module reservoir() {
    difference() {
        // main shell
        body(reservoirR, reservoirH);
        
        // hole for the motor axis
        translate([0, 0, 10])
        rotate([90, 0, 0])
        motor_axis(clearance, false);

        // carve a hole in the bottom for kibble
        rotate([0, 0, 90])
        translate([0, 0, -thickness])
        hole_shape(reservoirR - thickness, holeInnerRadius, 45);
    }
}


module body(radius, height) {
    difference() {
        body_shape(radius, height);
        
        translate([0, 0, thickness])
        body_shape(radius - thickness, height+1);
    }
}

module body_shape(radius, height) {
    w = radius * 1.9;
    topH = 40;

    hull() {
        translate([0, 0, height - topH])
        rect_rounded(w, w, topH, 10);

        translate([0, 0, 0])
        rotate([0, 0, 0])
        cylinder(1, r=radius, center=false, $fn=64);
    }
}
