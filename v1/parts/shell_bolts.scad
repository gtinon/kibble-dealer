include <../params.scad>

// for local tests only
shell_bottom_bolts();


module shell_bottom_bolts() {
    radius = 1.5 + clearance*2/3;
    height = 10;


    // shell + plate
    translate([inner_tube_radius * 1.1, -inner_tube_length/4, 0])
    cylinder(height, r = radius, center=true, $fn=24);

    translate([-inner_tube_radius * 1.1, -inner_tube_length/4, 0])
    cylinder(height, r = radius, center=true, $fn=24);


    // shell + plate + bottom
    translate([inner_tube_radius * 1.1, inner_tube_length/4, 0])
    cylinder(height, r = radius, center=true, $fn=24);

    translate([-inner_tube_radius * 1.1, inner_tube_length/4, 0])
    cylinder(height, r = radius, center=true, $fn=24);

    // plate + bottom
    translate([inner_tube_radius * 0.6, inner_tube_length / 2 + motor_plate_bottom_extra*2/3, 0])
    cylinder(height, r = radius, center=true, $fn=24);
    
    translate([-inner_tube_radius * 0.6, inner_tube_length / 2 + motor_plate_bottom_extra*2/3, 0])
    cylinder(height, r = radius, center=true, $fn=24);
}
