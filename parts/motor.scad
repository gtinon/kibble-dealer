include <../params.scad>

// for local tests only
motor_axis();


module motor_axis() {
    difference() {
        rotate([90,0,0])
        cylinder(motor_axis_length,r=motor_axis_radius,center=false,$fn=30);
        
        translate([-5,-motor_axis_length/2+1,motor_axis_plane_start])
        cube([10,motor_axis_length/2,10],center=false);
    }
}
