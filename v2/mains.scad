include <params.scad>

use <../utils/utils.scad>
use <../utils/motor.scad>

use <reservoir.scad>
use <carousel.scad>
use <bottom.scad>


cut([0.01,0,0])
//cut([0,-10,0])
//cut([0,0,1])
union() {

    carouselZ = clearance;
    translate([0, 0, carouselZ]) 
    carousel();

    reservoirZ = carouselZ + carouselH - 0.01;
    translate([0, 0, reservoirZ]) 
    reservoir();

    %translate([0, 0, -bottomH]) 
    bottom();

    // not to print
    translate([0, 0, -clearance]) 
    rotate([-90,0,0])
    motor(90);

}