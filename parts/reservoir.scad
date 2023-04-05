include <../params.scad>

use <connector.scad>

reservoir();


module reservoir() {
    radius = inner_tube_radius;
    length = hole_length * 0.7;
    adapter_h = 20;

    translate([0,0,adapter_h])
    connector_female();

    translate([0,0,0])
    reservoir_adapter(2, adapter_h, radius, length, 19);
}


module reservoir_adapter(wall_thickness, height, radius, length, dst_cut_cylinder=15) {
    rect_w = hole_width;
    rect_h = length;
    difference() {
        circle2rect(plug_diameter_min/2   + wall_thickness, rect_w + wall_thickness * 2, rect_h + wall_thickness * 2, height);
        circle2rect(plug_diameter_min/2 + 0.55, rect_w, rect_h, height+0.01);

        // adapt lower part to circular base
        translate([0,0,-dst_cut_cylinder])
        rotate([90,0,0])
        cylinder(length*2,r=radius,center=true,$fn=100);   
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


module input_shaft_shape(length, depth, base_width, max_width) {
    dw = max_width - base_width;
    
    rotate([-180,0,0]) 
    translate([-max_width/2,-depth/2,-length/2]) 
    linear_extrude(height=length) {
        polygon(points = [
            [0, 0],
            [max_width, 0],
            [max_width - dw/2, depth],
            [dw/2, depth]
        ]);
    }
        
}
