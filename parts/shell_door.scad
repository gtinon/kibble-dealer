include <../params.scad>

use <utils.scad>
use <motor.scad>

// for local tests only
shell_door();


module shell_door() {
    difference() {
        // door
        shell_door_without_hole();

        // hole
        translate([0,10,0])
        motor_axis(0, false);
    }
}

module shell_door_without_hole() {
    rotate([90,0,0])
    cylinder(thickness, r = inner_tube_radius + cylinder_radius_margin, center=false);

    door_spacer(7, motor_axis_radius, rear_axis_padding);

    translate([0, -thickness/2, 0])
    rotate([90,35,0])
    cube([inner_tube_radius * 2 + cylinder_radius_margin * 2 + thickness * 2, 5, thickness], center=true);
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