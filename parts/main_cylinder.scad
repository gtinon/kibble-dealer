include <../params.scad>

use <motor.scad>
use <cylinder_doors.scad>

// for local tests only
main_cylinder();
%motor_axis_positionned();
%rear_axis_positionned();


module main_cylinder() {
    difference() {
        // big cylinder
        rotate([90,0,0])
        union() {
            cylinder(inner_tube_length,r=inner_tube_radius-hole_depth,center=true,$fn=100);
            
            translate([0,0,-inner_tube_length/2])
            cylinder(inner_tube_radius,r1=inner_tube_radius,r2=0,center=false,$fn=200);
            
            rotate([180,0,0])
            translate([0,0,-inner_tube_length/2])
            cylinder(inner_tube_radius,r1=inner_tube_radius,r2=0,center=false,$fn=200);
        }
        
        // motor axis hole
        motor_axis_positionned(0.2);
        
        // rear axis hole
        rear_axis_positionned(0.2);
    }

    // payload blades
    for(i=[0:1:2]) {
        rotate(a=120*i+95,v=[0,1,0])
//        translate([0,0,inner_tube_radius-hole_depth/2*0.999])
        payload_blade();
    }
}

module motor_axis_positionned(radiusPadding=0) {
    translate([0,-inner_tube_length/2-0.01,0])
    rotate([180,0,0])
    motor_axis(radiusPadding);
}

module rear_axis_positionned(radiusPadding=0) {
    translate([0,inner_tube_length/2+0.01,0])
    rear_axis(radiusPadding, true);
}

module payload_blade() {
    
    rotate([90,0,0]) 
    translate([0,0,-hole_length/2]) 
    raw_payload_blade();
}

module raw_payload_blade() {
    hole_width_top=50;
    hole_width_bottom=12;
    hole_bottom_offset = hole_depth*0.1;
    
    axis_offset= inner_tube_radius - hole_depth;
    
    linear_extrude(height=hole_length) {
        polygon(points = [
            [5, axis_offset-5],
            [3, inner_tube_radius*0.50],
            [1, inner_tube_radius*0.70],
            [-1.5, inner_tube_radius*0.82],
            [-5, inner_tube_radius*0.90],
            [-8, inner_tube_radius*0.91],
            [-3, inner_tube_radius*0.5],
            [-4, axis_offset-3],
            [0 , axis_offset],
        ]);
    }
}

