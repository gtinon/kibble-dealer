include <../params.scad>

module front_door() {
    
    // padder
    translate([0,-inner_tube_length/2+front_axis_padding,0])
    rotate([90,0,0])
    front_door_padder(front_axis_padding);
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


module rear_axis() {    
    rotate([90,0,0])
    cylinder(rear_axis_length,r=rear_axis_radius,center=false,$fn=50);
}