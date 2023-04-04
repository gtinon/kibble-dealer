include <../params.scad>

use <utils.scad>
use <cylinder_doors.scad>
use <reservoir.scad>

// for local tests only
main_body();


module main_body() {    
    r=inner_tube_radius+cylinder_radius_margin;
    
    // tube
    rotor_shell(r);
    
    // rear door
    translate([0,inner_tube_length/2+thickness,0])
    rear_door(r);
    
    // reservoir
    //reservoir(r, 1);
}

module rotor_shell(radius) {
    difference() {
        union() {
            length = inner_tube_length + thickness * 2;
            
            // outer_cylinder
            rotate([90,0,0])
            cylinder(length,r=radius+thickness,center=true,$fn=100);

            // base
            shell_base(radius, length);

            // top
            //shell_top(radius, length);
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
    }
}

module rear_door(r) {
    rotate([-90,0,0])
    %cylinder(thickness,r=r+thickness,center=false);
    
    // spacer + rear axis
    axis_spacer(rear_axis_length,rear_axis_radius, rear_axis_padding);
    
     // axis
    rear_axis();
}


module axis_spacer(total_height, axis_radius, spacer_height) {
    radius_bottom=axis_radius*1.5;
    
    rotate([90,0,0])
    difference() {
        cylinder(total_height,r1=radius_bottom, r2=0,$fn=80,center=false);
        
        translate([0,0,total_height/2+spacer_height])
        cube([total_height*2,total_height*2,total_height], center=true);
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
