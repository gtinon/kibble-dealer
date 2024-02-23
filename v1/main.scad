include <params.scad>

use <../utils/utils.scad>
use <../utils/motor.scad>
use <parts/shell.scad>
use <parts/shell_door.scad>
use <parts/screw.scad>
use <parts/motor_plate.scad>
use <parts/bottom.scad>
use <parts/reservoir.scad>

spacing=0.1;

*translate([0,-shell_length/2 + input_hole_offset/2,shell_radius_outer+0.5])
cube([1,input_hole_offset,1], center=true);

cut([-0.01,0,0])
//cut([0,-10,0])
//cut([0,0,1])
union() {

    // outer shell
    translate([0,0,0])
    main_body();

    // motor door
    translate([0,-inner_tube_length/2 - front_axis_padding, 0])
    shell_door();

    // inner cylinder
    translate([0,-inner_tube_length/2 + spacing,0])
    rotate([-90,90,0])
    infinite_screw();


    // middle plate
    translate([0,
        inner_tube_length/2 + front_axis_padding + rear_axis_padding,
        -inner_tube_radius - shell_plate_thickness - spacing])
    motor_plate();


    // top adapter
    translate([0, -shell_length/2  + input_hole_offset + input_hole_length/2,
        shell_radius_outer + spacing])
    reservoir();

    // bottom adapter
    translate([0, shell_length/2 - bottom_hole_length/2 - thickness + bottom_offset,
        -(shell_radius_outer + shell_plate_thickness + spacing*2)])
    bottom();



    // not to print
    translate([0,-inner_tube_length/2 - rear_axis_padding - thickness - spacing*1, 0]) 
    rotate([0,0,180])
    motor(90);


    // TODO
    // box for the electronics => separate
}



