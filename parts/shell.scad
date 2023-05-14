include <../params.scad>

use <utils.scad>
use <shell_door.scad>
use <shell_bolts.scad>

// for local tests only
//cut([-0.01,0,0])
cut([0,-0.01,0])
main_body();

module main_body() {
    // tube
    rotor_shell();
    
    rotate([0,90,0])
    motor_clamp();
    
    rotate([0,-90,0])
    motor_clamp();

    // rear panel
    translate([0,inner_tube_length/2 + rear_axis_padding, 0])
    rear_panel(shell_radius_inner);
}

module rotor_shell() {
    difference() {
        union() {
            // outer_cylinder
            rotate([90,0,0])
            cylinder(shell_length,r=shell_radius_outer,center=true,$fn=100);

            // base
            shell_base(shell_radius_outer, shell_length);

            // top
            translate([0,0,0])
            shell_top(shell_radius_outer, shell_length);
        }

        // carve inside
        rotate([90,0,0])
        cylinder(shell_length+100,r=shell_radius_inner,center=true,$fn=100);
        
        // bottom hole
        color("#00ff00")
        translate([0,inner_tube_length/2 + rear_axis_padding - bottom_hole_length/2, -shell_radius_outer])
        cube([bottom_hole_width,bottom_hole_length,7], center=true);
        
        // top hole
        color("#00ff00")
        translate([0, -shell_length/2 + input_hole_length/2 + input_hole_offset, shell_radius_outer])
        cube([input_hole_width,input_hole_length,20], center=true);

        // door notches
        translate([0, -shell_length/2 + thickness -0.01, 0])
        shell_door(clearance*2);

        // bottom bolt holes
        color("#ff0000")
        translate([0,0,-inner_tube_radius-2])
        shell_bottom_bolts();
    }
}

module rear_panel(r) {
    rotate([-90,0,0])
    cylinder(thickness,r=r+thickness,center=false);
    
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
    
    // base to hold cylinder and bottom plate
    translate([0, 0, -radius + base_thickness/2])
    cube([base_width,length,base_thickness], center=true);

    // plate
    translate([0, 0, -radius + shell_plate_thickness/2])
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
    top_thickness = 5.5;
    top_width = radius * 1.3;
    rails_h = 2.5;

    translate([0, 0, radius])
    difference() {
        union() {
            // base
            translate([0, 0, -top_thickness/2])
            cube([top_width, length, top_thickness], center=true);

            // plate in which rails are cut
            w=top_width + thickness * 4;
            translate([-w/2, -length/2, -thickness])
            cube([w, length, thickness + rails_h], center=false);
        }
        
        // carve rails
        translate([0, -5, clearance])
        reservoir_rail_male(inner_tube_length, clearance);
    }
}

module motor_clamp() {
    offset = 5;
    lock_len = 30;
    lock_w = 15;
    lock_thickness = 4;

    translate([0, -lock_len/2 - offset, inner_tube_radius+cylinder_radius_margin + lock_thickness/2 + 0.5])
    rotate([90,0,-90])
    trapezoid(lock_len, lock_len * 0.2, lock_thickness, lock_w, lock_len * 0.4);
}

module reservoir_rail_male(length, padding=0) {
    clip_h = 7;
    clip_w_min = input_hole_width + 4;
    clip_w_max = input_hole_width + 9;

    translate([0, 0, clip_h/2])
    rotate([90, 0, 0])
    trapezoid(clip_w_max + padding*2, clip_w_min + padding*2, clip_h + padding*2, length);
}
