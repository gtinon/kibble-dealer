include <../params.scad>

use <utils.scad>
use <shell_door.scad>
use <reservoir.scad>
use <shell_bolts.scad>

// for local tests only
main_body();


module main_body() {    
    r=inner_tube_radius+cylinder_radius_margin;
    
    // tube
    rotor_shell(r);
    
    rotate([0,90,0])
    motor_lock();
    
    rotate([0,-90,0])
    motor_lock();

    // rear panel
    translate([0,inner_tube_length/2+thickness,0])
    rear_panel(r);
    
    // reservoir
    translate([0,0,21])
    reservoir();
}

module rotor_shell(radius) {
    length = inner_tube_length + thickness * 2;

    difference() {
        union() {
            
            // outer_cylinder
            rotate([90,0,0])
            cylinder(length,r=radius+thickness,center=true,$fn=100);

            // base
            shell_base(radius, length);

            // top
            // shell_top(radius, length);
        }

        // carve inside
        rotate([90,0,0])
        cylinder(inner_tube_length+thickness*4,r=radius,center=true,$fn=100);
        
        // bottom hole
        translate([0,0,-radius])
        cube([bottom_hole_width,hole_length,7], center=true);
        
        // top hole
        translate([0,0,radius])
        cube([hole_width,hole_length*0.7,7], center=true);

        // door notches
        translate([0, -length/2+thickness, 0])
        shell_door();

        // bottom bolt holes
        color("#ff0000")
        translate([0,0,-inner_tube_radius-2])
        shell_bottom_bolts();
    }
}

module rear_panel(r) {
    rotate([-90,0,0])
    %cylinder(thickness,r=r+thickness,center=false);
    
    // spacer + rear axis
    // color("#0000AA")
    rear_panel_spacer(rear_axis_length, rear_axis_radius, rear_axis_padding);
    
     // axis
    rear_axis();
}

module rear_panel_spacer(total_height, axis_radius, spacer_height) {
    radius_bottom=axis_radius*1.5;

    // truncated cone    
    rotate([90,0,0])
    difference() {
        cylinder(total_height,r1=radius_bottom, r2=0,$fn=80,center=false);
        
        translate([0,0,total_height/2+spacer_height])
        cube([total_height*2,total_height*2,total_height], center=true);
    }
}

module rear_axis(radiusPadding=0, addTopCone=false) {    
    rotate([90,0,0])
    cylinder(rear_axis_length,r=rear_axis_radius+radiusPadding,center=false,$fn=80);

    if (addTopCone) {
        coneR = rear_axis_radius + radiusPadding;
        
        translate([0,-rear_axis_length,0])
        rotate([90,0,0])
        cylinder(h=coneR*1.2,r1=coneR,r2=0,center=false,$fn=80);
    }
}

module shell_base(radius, length) {
    base_thickness = 10;
    base_width = radius * 1.6;
    
    // base
    translate([0,thickness/2,-radius-thickness+base_thickness/2])
    cube([base_width,length+thickness,base_thickness], center=true);

    translate([0, thickness/2, -radius - thickness + shell_plate_thickness/2])
    union() {
        // plate center
        cube([shell_plate_width, shell_plate_length, shell_plate_thickness], center=true);

        // plate right wing
        translate([shell_plate_width/2 + shell_plate_wing_height/2, 0, 0])
        rotate([0,0,-90])
        trapezoid(shell_plate_length, shell_plate_length * 0.6, shell_plate_wing_height, shell_plate_thickness);

        // plate left wing
        translate([-shell_plate_width/2 - shell_plate_wing_height/2, 0, 0])
        rotate([0,0,90])
        trapezoid(shell_plate_length, shell_plate_length * 0.6, shell_plate_wing_height, shell_plate_thickness);
    }
    
}

module shell_top(radius, length) {
    top_thickness = 10;
    top_width = radius * 1.5;

    // base
    translate([0, thickness/2, radius + thickness - top_thickness/2])
    cube([top_width, length + thickness, top_thickness], center=true);

    translate([0, thickness/2,+ radius + thickness])
    cube([top_width + thickness * 2, length + thickness, thickness], center=true);
}

module motor_lock() {
    offset = 5;
    lock_len = 30;
    lock_w = 15;
    lock_thickness = 4;

    translate([0, -lock_len/2 - offset, inner_tube_radius+cylinder_radius_margin + lock_thickness/2 + 0.5])
    rotate([90,0,-90])
    trapezoid(lock_len, lock_len * 0.2, lock_thickness, lock_w, lock_len * 0.4);
}