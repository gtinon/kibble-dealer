include <params.scad>

use <parts/shell.scad>
use <parts/shell_door.scad>
use <parts/main_cylinder.scad>
use <parts/motor.scad>
use <parts/motor_plate.scad>
use <parts/bottom.scad>


// outer shell
%main_body();

// motor door
translate([0,-inner_tube_length/2-0.01,0])
shell_door();

// inner cylinder
translate([0,1,0])
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
// holes for bolts => 3mm diameter
// connector for reservoir

// box for the electronics => separate




