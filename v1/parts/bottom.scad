include <../params.scad>

use <connector.scad>
use <shell_bolts.scad>


*rotate([0,0,90])
cube([bottom_hole_width-0.1, bottom_hole_length-0.1, 1], center=true);

bottom();

coverH = 1.5;
holeH = 5;


module bottom() {
    difference() {
        rotate([0,0,90])
        bottom_without_holes();
                    
        color("#ff0000")
        translate([0, -(shell_length/2 - bottom_hole_length/2 - thickness + bottom_offset), -3])
        //rotate([0,0,-90])
        shell_bottom_bolts();
    }
}

module bottom_without_holes() {
    translate([0, 0, -plug_height_male - coverH])
    connector_male();

    translate([0,0,-coverH])
    diffHullThenAdd() {
        // cover
        cylinder(coverH, r=plug_diameter_max/2, $fn=100);

        // payload hole
        translate([-bottom_offset,0,0])
        rotate([0,0,90])
        payload_hole(bottom_hole_width, bottom_hole_length, holeH, coverH);
    }   
}

module payload_hole(width, length, depth, wallW) {
    translate([0,0,-depth/2+wallW+0.01])
    difference() {
        cube([width + 2*wallW, length + 2*wallW, depth], center=true);

        color("#00aa00")
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

