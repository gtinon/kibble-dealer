include <../params.scad>

use <utils.scad>
use <shell_bolts.scad>


motor_plate();

w = shell_plate_width + shell_plate_wing_height * 2;
w2 = shell_plate_width;
wing_h = shell_plate_length * 0.2;
plate_len = -wing_h + motor_plate_bottom_extra + shell_plate_length + motor_block_and_disk_length + thickness + clearance;

bumper_rear_h = 8;
bumper_side_h = 8;
bumper_side_w = 10;

module motor_plate() {
    difference() {
        translate([0, motor_plate_bottom_extra, 0])
        base_plate();
        
        // payload hole
        color("#ff0000")
        translate([0, -bottom_hole_length/2 - thickness, 0])
        cube([bottom_hole_width, bottom_hole_length, 10], center=true);

        color("#ff0000")
        translate([0, -(inner_tube_length/2 + front_axis_padding + rear_axis_padding), 0])
        shell_bottom_bolts();
    }

    translate([0, -wing_h -plate_len + motor_plate_bottom_extra, shell_plate_thickness/2])
    motor_rear_bumper();
}

module base_plate() {
    // shell end of the plate
    translate([0, -wing_h/2, 0])
    trapezoid(w, w2, wing_h, shell_plate_thickness);

    // main plate
    translate([0, -wing_h - plate_len/2, 0])
    cube([w, plate_len, shell_plate_thickness], center=true);

    // motor height compensation
    comp_h = inner_tube_radius + cylinder_radius_margin + thickness - motor_block_side/2;
    translate([0, -wing_h -plate_len + motor_block_length/2 + thickness, shell_plate_thickness/2 + comp_h/2])
    cube([motor_block_side*0.8, motor_block_length + thickness, comp_h], center=true);
}

module motor_rear_bumper() {
    // rear bumper
    translate([0, thickness/2, bumper_rear_h/2])
    cube([motor_block_side + thickness * 2, thickness, bumper_rear_h], center=true);

    // left bumper
    translate([motor_block_side/2 + thickness/2, bumper_side_w/2, bumper_side_h/2])
    side_bumper(bumper_side_h, bumper_side_w);

    // right bumper
    translate([-motor_block_side/2 - thickness/2, bumper_side_w/2, bumper_side_h/2])
    side_bumper(bumper_side_h, bumper_side_w);

}

module side_bumper(bumper_side_h, bumper_side_w) {
    rotate([90,0,90])
    trapezoid(bumper_side_w, bumper_side_w * 0.7, bumper_side_h, thickness, -bumper_side_w * 0.15);
}


