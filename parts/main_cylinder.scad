include <../params.scad>

use <motor.scad>
use <cylinder_doors.scad>

// for local tests only
main_cylinder();
%motor_axis();
%rear_axis_positionned();
*payload_hole();

module main_cylinder() {
    difference() {
        // big cylinder
        rotate([90,0,0])
        cylinder(inner_tube_length,r=inner_tube_radius,center=true,$fn=100);
        
        // motor axis hole
        motor_axis();
        
        // rear axis hole
        rear_axis_positionned();
        
        // payload holes
        //rotate([90,0,0])
        for(i=[0:1:3]) {
            rotate(a=90*i,v=[0,1,0])
            translate([0,0,inner_tube_radius-hole_depth/2*0.999])
            payload_hole();
        }
    }
}

module rear_axis_positionned() {
    translate([0,inner_tube_length/2,0])
    rear_axis();
}

module payload_hole() {
    dw = hole_wmax - hole_wmin;
    
    rotate([-90,0,180]) 
    translate([-hole_wmax/2,-hole_depth/2,-hole_length/2]) 
    linear_extrude(height=hole_length) {
        polygon(points = [
            [0, 0],
            [hole_wmax*2, 0],
            [hole_wmax*1, hole_depth/2],
            [hole_wmax - dw/2, hole_depth],
            [dw/2, hole_depth]
        ]);
    }
}

