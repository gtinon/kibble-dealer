include <../params.scad>



// for local tests only
motor();


module motor() {
    motor_axis();
    motor_block();
}

module motor_axis(radiusPadding=0, with_flat_section=true) {
    difference() {
        rotate([90,0,0])
        cylinder(motor_axis_length,r=motor_axis_radius+radiusPadding,center=false,$fn=100);
        
        if (with_flat_section) {
            translate([-5,-motor_axis_length-1,motor_axis_radius_flat])
            cube([10,motor_axis_length+2,10],center=false);
        }
    }
}

module motor_block() {
    rotate([90,0,0])
    translate([0,0,-motor_disk_length])
    cylinder(motor_disk_length,r=motor_disk_diameter/2,center=false,$fn=30);
        
    difference() {
        rotate([90,0,0])
        translate([-motor_block_side/2,-motor_block_side/2,-motor_block_length-motor_disk_length])
        cube([motor_block_side,motor_block_side,motor_block_length],center=false);
        
        for(i=[0:1:3]) {
            rotate([0,45+90*i,0])
            translate([0,0,motor_block_flat_diameter/2])
            motor_block_edge_cutter();
        }
    }
}

module motor_block_edge_cutter() {
    rotate([90,0,0])
    translate([-motor_block_side/2,0,-motor_block_length-motor_disk_length-1])
    cube([motor_block_side,10,motor_block_length+2],center=false);
}