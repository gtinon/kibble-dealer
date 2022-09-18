include <../params.scad>

// for local tests only
rear_axis(0.2, true);

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