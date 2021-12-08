include <parts/params.scad>

use <parts/shell.scad>
use <parts/main_cylinder.scad>
use <parts/motor.scad>


// outer shell
%main_body();

// inner cylinder
main_cylinder();

// not to print
motor_axis();


// TODO
// lockable door with axis hole
// ground support to stabilize/attach the thingy
// kibble ramp at the bottom (must be smart cat safe !!)
// make an adapter for a bottle or something at the top of the reservoir (too big and too low value to print this)
// add a support for the motor
// add a protection for the motor

// printing specific questions
// need to remove stuff from main cylinder?
// 



