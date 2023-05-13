include <../params.scad>

use <connector.scad>
use <shell.scad>
use <utils.scad>

reservoir();

module reservoir() {
    radius = inner_tube_radius;
    length = input_hole_length;
    adapter_h = 30;

    // top
    translate([0,0,adapter_h])
    connector_female();

    // bottom
    translate([0,0,0])
    reservoir_adapter(2, adapter_h, radius, length, 19);
}


module reservoir_adapter(wall_thickness, height, radius, length, dst_cut_cylinder=15) {
    rect_w = input_hole_width;
    rect_h = length;
    difference() {
        union() {
            circle2rect(plug_diameter_min/2   + wall_thickness, rect_w + wall_thickness * 2, rect_h + wall_thickness * 2, height);

            // rail female part
            translate([0, 0, -0.05])
            reservoir_rail_male(input_hole_length * 0.92);

            // holding tab
            translate([0, -input_hole_length/2 - thickness, -0.05])
            holding_tab();
        }
        
        translate([0,0,-0.01])
        circle2rect(plug_diameter_min/2 + 0.55, rect_w, rect_h, height+0.02);  
    }
}


module circle2rect(radius, rect_w, rect_h, height) {
    hull() {
        cube([rect_w,rect_h,0.1], center=true);

        translate([0,0,height])
        rotate([0,0,0])
        cylinder(0.1,r=radius,center=false, $fn=48);
    }
}

module holding_tab() {
    tab_base_h = 9;
    tab_len = 7.5;
    tab_w = 20;

    // base
    translate([0, -tab_len/2, tab_base_h/2])
    rotate([90, 0, 90])
    trapezoid(tab_len, 0, tab_base_h, tab_w, tab_len/2);

    // vertical clip
    clip_h = 7;
    clip_thickness = 1.5;
    translate([0, -tab_len +1 + clip_thickness/2, -clip_h/2])
    cube([tab_w, clip_thickness, clip_h], center=true);

    // motor holder small extension
    holder_h = 3.1;
    holder_len = 2;
    translate([0, -tab_len + 1 - holder_len/2, -holder_h/2])
    rotate([90, 0, 90])
    trapezoid(holder_len, 1, holder_h, tab_w, (holder_len-1)/2);
}
