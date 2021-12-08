include <../params.scad>
use <motor.scad>

// for local tests only
main_cylinder();
*motor_axis();

module main_cylinder() {
    difference() {
        union() {
            // big cylinder
            rotate([90,0,0])
            cylinder(inner_tube_length-rear_axis_padding*2,r=inner_tube_radius,center=true,$fn=100);
            
            // rear axis/pin
            translate([0,inner_tube_length/2-rear_axis_padding,0])
            rotate([-90,0,0])
            cylinder(rear_axis_length*0.9,r=rear_axis_radius,center=false,$fn=50);
            
            // front padder
            translate([0,-inner_tube_length/2+front_axis_padding,0])
            rotate([90,0,0])
            front_door_padder(front_axis_padding);
        }
        
        // motor axis hole
        motor_axis();
        
        // payload holes
        rotate([90,0,0])
        for(i=[0:1:3]) {
            rotate(a=90*i,v=[0,0,1]) 
            translate([0,inner_tube_radius-hole_depth/2*0.999,0])
            payload_hole();
        }
    }
}

module payload_hole() {
    dw = hole_wmax - hole_wmin;
    
    rotate([-180,0,0]) 
    translate([-hole_wmax/2,-hole_depth/2,-hole_length/2]) 
    linear_extrude(height=hole_length) {
        polygon(points = [
            [0, 0],
            [hole_wmax, 0],
            [hole_wmax - dw/2, hole_depth],
            [dw/2, hole_depth]
        ]);
    }
}

module front_door_padder(height) {
    radius_bottom=motor_axis_radius*2.5;
    radius_top=motor_axis_radius*1.5;
    
    // cone
    rotate_extrude(angle=360)
    polygon(points = [
        [0, 0],
        [radius_bottom, 0],
        [radius_top, height],
        [0, height]
    ]);
}

