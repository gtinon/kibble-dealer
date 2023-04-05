include <../params.scad>

// for local tests only
shell_bottom_bolts();


module shell_bottom_bolts() {
    radius = 1.5;
    height = 10;

    translate([inner_tube_radius * 1.1, inner_tube_length/4, 0])
    cylinder(height, r = radius, center=true, $fn=12);

    translate([inner_tube_radius * 1.1, -inner_tube_length/4, 0])
    cylinder(height, r = radius, center=true, $fn=12);

    translate([-inner_tube_radius * 1.1, inner_tube_length/4, 0])
    cylinder(height, r = radius, center=true, $fn=12);

    translate([-inner_tube_radius * 1.1, -inner_tube_length/4, 0])
    cylinder(height, r = radius, center=true, $fn=12);

}
