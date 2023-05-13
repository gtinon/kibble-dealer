include <../params.scad>

use <connector.scad>
use <shell_bolts.scad>


bottom();

coverH = 1.5;
holeH = 5;


module bottom() {
    
    translate([0,0,-plug_height_male-coverH])
    connector_male();

    translate([0,0,-coverH])
    diffHullThenAdd() {
        // cover
        top_cover();

        // payload hole
        rotate([0,0,90])
        payload_hole(bottom_hole_width, bottom_hole_length, holeH, coverH);
    }   
}

module top_cover() {
    difference() {
        cylinder(coverH, r=plug_diameter_max/2, $fn=100);
            
        color("#ff0000")
        rotate([0,0,90])
        translate([0,1,3])
        shell_bottom_bolts();
    }
}

module payload_hole(width, length, depth, wallW) {
    color("#00aa00")
    translate([0,0,-depth/2+wallW+0.01])
    difference() {
        cube([width + 2*wallW, length + 2*wallW, depth], center=true);

        //translate([-wallW/2-0.01,0,0])
        cube([width, length, depth*2], center=true);
    }
}

module diffHullThenAdd() {
    difference() {
        children(0);

        for(i=[1:$children-1])
            hull()
            children(i);
    }

    for(i=[1:$children-1])
        children(i);
}

