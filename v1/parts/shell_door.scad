include <../params.scad>

use <utils.scad>
use <motor.scad>

// for local tests only
shell_door();


module shell_door(notch_bonus_width=0) {
    difference() {
        // door
        shell_door_without_hole(notch_bonus_width);

        // hole
        translate([0,10,0])
        motor_axis(0.3, false);
    }
}

module shell_door_without_hole(notch_bonus_width) {
    rotate([90,0,0])
    cylinder(thickness, r = inner_tube_radius + cylinder_radius_margin, center=false, $fn=64);

    door_spacer(6, motor_axis_radius+2, rear_axis_padding);

    translate([0, -thickness/2, 0])
    rotate([90,35,0])
    cube([inner_tube_radius * 2 + cylinder_radius_margin * 2 + thickness * 2, 5 + notch_bonus_width, thickness], center=true);
}

module door_spacer(total_height, axis_radius, spacer_height) {
    radius_bottom=axis_radius*1.5;
    
    // truncated cone
    rotate([-90,0,0])
    difference() {
        cylinder(total_height,r1=radius_bottom, r2=0,$fn=80,center=false);
        
        translate([0,0,total_height/2+spacer_height])
        cube([total_height*2,total_height*2,total_height], center=true);
    }
}