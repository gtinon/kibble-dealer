include <params.scad>

use <parts/utils.scad>
use <parts/shell.scad>
use <parts/shell_door.scad>
use <parts/screw.scad>
use <parts/motor.scad>
use <parts/motor_plate.scad>
use <parts/bottom.scad>
use <parts/reservoir.scad>

spacing=0.1;

cut([-0.01,0,0])
//cut([0,-10,0])
//cut([0,0,1])
union() {
    // outer shell
    translate([0,spacing,0])
    main_body();

    // motor door
    translate([0,-inner_tube_length/2-0.01,-0.3])
    shell_door();

    // inner cylinder
    translate([0,-inner_tube_length/2+1,0])
    rotate([-90,0,0])
    infinite_screw();

    // plate
    translate([0,
        inner_tube_length/2-thickness*4,
        -inner_tube_radius - shell_plate_thickness - thickness/2-spacing])
    motor_plate();

    // bottom adapter
    translate([0, 24.5,
        -(inner_tube_radius+cylinder_radius_margin+thickness+shell_plate_thickness+spacing*2)])
    rotate([0,0,90])
    bottom();
        
    // top adapter
    translate([0, -inner_tube_length/2 + input_hole_width/2 + thickness + input_hole_offset + 0.4,
        inner_tube_radius+cylinder_radius_margin+thickness*2+spacing])
    reservoir();

    // not to print
    translate([0,-inner_tube_length/2 - thickness - spacing*2, -0.2]) 
    rotate([0,0,180])
    motor();


    // TODO
    // box for the electronics => separate
}



