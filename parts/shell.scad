include <../params.scad>

use <cylinder_doors.scad>

// for local tests only
main_body();


module main_body() {    
    r=inner_tube_radius+cylinder_radius_margin;
    
    union() {
        // tube
        rotor_shell(r);
        
        // rear door
        translate([0,inner_tube_length/2+thickness,0])
        rear_door(r);
    }
}

module rotor_shell(radius) {
    difference() {
        // outer_cylinder
        rotate([90,0,0])
        cylinder(inner_tube_length+thickness*2,r=radius+thickness,center=true,$fn=100);

        // carve inside
        rotate([90,0,0])
        cylinder(inner_tube_length+thickness*4,r=radius,center=true,$fn=100);
        
        // lower opening
        translate([0,0,-radius])
        cube([hole_width,hole_length,7], center=true);
            
        // top hole for feeder
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

