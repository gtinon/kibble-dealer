include <../params.scad>

use <connector.scad>


bottom();


module bottom() {
    coverH = 1.5;
    holeH = 5;
    
    translate([0,0,-plug_height_male-coverH])
    connector_male();

    translate([0,0,-coverH])
    diffHullThenAdd() {
        // cover
        cylinder(coverH, r=plug_diameter_max/2, $fn=100);
        
        // payload hole
        rotate([0,0,90])
        snap_fit_hole(bottom_hole_width, hole_length, holeH, coverH);
    }
}

module snap_fit_hole(width, length, depth, wallW) {
    color("#00aa00")
    translate([0,0,-depth/2+wallW+0.01])
    difference() {
        cube([width,length,depth], center=true);

        //translate([-wallW/2-0.01,0,0])
        cube([width-2*wallW, length-2*wallW, depth*2], center=true);
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

