include <../params.scad>

use <connector.scad>
use <shell.scad>
use <utils.scad>

//cut([-0.01,0,0])
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
            translate([0, 0, -0.01])
            reservoir_rail_male(input_hole_length * 0.9);

            // holding tab
            //color("#00aaaa")
            translate([0, -input_hole_length/2, 0])
            holding_tab();
        }
        
        translate([0,0,-0.01])
        circle2rect(plug_diameter_min/2 + 0.55, rect_w, rect_h, height+0.02);  
    }
}


module circle2rect(radius, rect_w, rect_h, height) {
    hull() {
        translate([0,0,0.05 - 0.001])
        cube([rect_w,rect_h,0.1], center=true);

        translate([0,0,height])
        rotate([0,0,0])
        cylinder(0.1,r=radius,center=false, $fn=48);
    }
}

module holding_tab() {
    clip_h = 7;
    clip_thickness = motor_disk_length - clearance*1.5;

    holder_h = 0.5 - clearance*0.5;
    holder_len = 2;

    tab_base_h = 10;
    tab_len = input_hole_offset + clearance + clip_thickness + holder_len;
    tab_w = input_hole_width;

    // base
    translate([0, -tab_len/2, tab_base_h/2])
    rotate([90, 0, 90])
    trapezoid(tab_len, 0, tab_base_h, tab_w, tab_len/2);

    // vertical clip
    translate([0, -(input_hole_offset + clearance + clip_thickness) + clip_thickness/2, -clip_h/2])
    cube([tab_w, clip_thickness, clip_h], center=true);

    // motor holder small extension
    translate([0, -tab_len + holder_len/2, -holder_h/2])
    cube([tab_w, holder_len, holder_h], center=true);
}
