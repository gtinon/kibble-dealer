include <params.scad>
include <../utils/utils.scad>

include <../utils/motor.scad>

// for tests
//cut([0,1,0])
bottom();

%translate([0, 0, motor_block_and_disk_length + thickness])
rotate([-90, 0, 0])
motor();



module bottom() {
    difference() {
        body(reservoirR, bottomH);


    }

    w = reservoirR * 0.7;
    translate([reservoirR * 1 - 1, 0, 40])
    rotate([90, 0, 0])
    trapezoid(1, w, bottomH/2, 20, -reservoirR * 0.35);

    //difference() {
    //    h = 40;
    //    translate([reservoirR*0.2, h/2, h+10])
    //    rotate([90, 30, 0])
    //    cube([reservoirR, h, h]);
    //    
    //    translate([-100+30, -reservoirR/2, 0])
    //    cube(100);
    //    
    //    translate([0, 0, 250+bottomH])
    //    cube([500, 500, 500], center=true);
    //}

    motor_holders();
}


module body(radius, height) {
    difference() {
        cylinder(bottomH, r=reservoirR, center=false);
        
        translate([0, 0, thickness])
        cylinder(bottomH, r=reservoirR - thickness, center=false);
    }
}

module motor_holders() {
    h = 12;
    w = 20;
    thickness = 3;
    
    holder_offset = -motor_block_side/2 - thickness/2 - clearance;
    for(i=[0:1:3]) {
        rotate([0, 0, -90 * i])
        translate([holder_offset, holder_offset, 0])
        rotate([0, 0, -90])
        motor_holder(h, w, thickness);
    }
}

module motor_holder(h, w, thickness) {
    half_holder(h, w, thickness);
    
    rotate([0,0,90])
    half_holder(h, w, thickness);
}

module half_holder(h, w, thickness) {
    translate([0, w/2 - thickness/2, h/2])
    rotate([90,0,90])
    trapezoid(w, w * 0.7, h, thickness, -w * 0.15);
}