include <params.scad>
include <../utils/utils.scad>

use <../utils/motor.scad>
use <carousel_hole.scad>


// for tests
// cut([-.001,0,0])
carousel();


spacerH = 1;
rotatorR = reservoirR - thickness - clearance - clearance;
rotatorH = carouselH - spacerH - clearance*2 - thickness*2;
innerR = reservoirR * 0.35;

module carousel() {
    carousel_shell();

    // bottom spacer (attached to the stator to try and reduce kibble dust reaching the motor)
    translate([0, 0, thickness])
    spacer(innerR, spacerH);


    translate([0, 0, thickness + spacerH + clearance])
    carousel_rotator();
}

module carousel_shell() {
    difference() {
        cylinder(carouselH, r=reservoirR, center=false, $fn=128);

        translate([0, 0, thickness])
        cylinder(carouselH, r=reservoirR - thickness, center=false, $fn=128);

        // hole for the motor axis
        translate([0, 0, 20])
        rotate([90, 0, 0])
        motor_axis(clearance, false);

        // hole in the bottom for kibble
        rotate([0, 0, 0])
        translate([0, 0, -thickness])
        hole_shape(reservoirR - thickness, reservoirR*0.4, 45);
    }
}

module carousel_rotator() {
    difference() {
        carousel_rotator_no_hole();
                    
        // hole for the motor axis with flat part
        translate([0, 0, 20])
        rotate([90, 0, 0])
        motor_axis(clearance, true);
    }
}

module carousel_rotator_no_hole() {
    translate([0, 0, 0])
    carousel_base_rotator();

    // top spacer
    translate([0, 0, rotatorH])
    spacer(innerR, spacerH);
}

module carousel_base_rotator() {
    outerThickness = 4;
    dividerW = 7;

    // outer ring
    difference() {
        cylinder(rotatorH, r=rotatorR, center=false, $fn=128);
        
        translate([0, 0, -thickness])
        cylinder(rotatorH*2, r=rotatorR - outerThickness, center=false, $fn=128);
    }

    // inner disc
    cylinder(rotatorH, r=innerR, center=false, $fn=64);

    // dividers
    for(i=[0:1:7]) {
        rotate([0, 0, 45*i])
        translate([0, -innerR, 0])
        beam(rotatorR - innerR - 1, dividerW, rotatorH);
    }
}

module beam(length, w, h) {
    rotate([90, 0, 0])
    translate([0, h/2, length/2])
    trapezoid(w*1.2, 2, h, length, top_offset_x = w * 0.7);
}

module spacer(r, h) {
    color("#0000aa")
    cylinder(h, r=r, center=false, $fn=128);
}

