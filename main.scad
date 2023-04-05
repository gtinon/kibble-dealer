include <params.scad>

use <parts/shell.scad>
use <parts/main_cylinder.scad>
use <parts/motor.scad>
use <parts/motor_plate.scad>
use <parts/bottom.scad>


// outer shell
%main_body();

// inner cylinder
main_cylinder();

// plate
translate([0,
    inner_tube_radius - thickness,
    -inner_tube_radius - shell_plate_thickness - thickness/2])
motor_plate();

// bottom adapter
translate([0,
    thickness/2,
    -(inner_tube_radius+cylinder_radius_margin+thickness+shell_plate_thickness)])
rotate([0,0,90])
%bottom();

// not to print
rotate([0,0,180])
translate([0,25 + thickness,0]) 
motor();


// TODO
// holes for bolts => size ?
// door with axis hole
// ground support to stabilize/attach the thingy
// add a support for the motor
// add a support + protection for the electronics




