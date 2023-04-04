include <params.scad>

use <parts/shell.scad>
use <parts/main_cylinder.scad>
use <parts/motor.scad>
use <parts/bottom.scad>


// outer shell
%main_body();

translate([0,thickness/2,-(inner_tube_radius+cylinder_radius_margin+thickness/2)])
rotate([0,0,90])
%bottom();

// inner cylinder
main_cylinder();

// not to print
rotate([0,0,180])
translate([0,25,0])
motor();


// TODO
// holes for bolts => size ?
// door with axis hole
// ground support to stabilize/attach the thingy
// add a support for the motor
// add a support + protection for the electronics




