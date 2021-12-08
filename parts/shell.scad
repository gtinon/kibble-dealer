include <../params.scad>

// for local tests only
main_body();


module main_body() {    
    r=inner_tube_radius+cylinder_radius_margin;
    
    union() {
        difference() {
            // join pieces
            union() {
                // tube
                rotor_shell(r);
                
                // rear door
                %translate([0,inner_tube_length/2+thickness,0])
                rotate([-90,0,0])
                cylinder(thickness,r=r+thickness,center=false);
                
                // input thingy
                input_shaft(r, 3);
            }
            
            // hole connecting both pieces
            translate([0,0,r])
            cube([hole_wmax,hole_length,7], center=true);
        }
        
        // rear support for the main cylinder rear axis
        translate([0,inner_tube_length/2+thickness,0])
        rotate([90,0,0])
        axis_support(rear_axis_length-rear_axis_padding,rear_axis_radius);
    }
}

module rotor_shell(radius) {
    difference() {
        // outer_cylinder
        rotate([90,0,0])
        cylinder(inner_tube_length+thickness*2,r=radius+thickness,center=true);

        // carve inside
        rotate([90,0,0])
        cylinder(inner_tube_length+thickness*4,r=radius,center=true,$fn=100);
        
        // lower opening
        translate([0,0,-radius])
        cube([hole_wmax,hole_length,7], center=true);
    }
}

module input_shaft(radius, scale) {
    difference() {
        translate([0,0,reservoirH])
        rotate([90,0,0])
        input_shaft_shape(hole_length+thickness, reservoirH, hole_wmin*scale+thickness, hole_wmax*scale+thickness);
        
        // remove inside
        translate([0,0,reservoirH+thickness])
        rotate([90,0,0])
        input_shaft_shape(hole_length, reservoirH, hole_wmin*scale, hole_wmax*scale);
        
        // adapt lower part to circular base
        rotate([90,0,0])
        cylinder(hole_length*2,r=radius,center=true,$fn=100);
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


module axis_support(height, axis_radius) {
    
    radius_bottom=axis_radius*4;
    radius_top=axis_radius*2;
    
    difference() {
        // cone
        rotate_extrude(angle=360)
        polygon(points = [
            [0, 0],
            [radius_bottom, 0],
            [radius_top, height],
            [0, height]
        ]);
        
        // hole
        translate([0,0,-height/2])
        cylinder(height*2,r=axis_radius,$fn=16,center=false);
    }
}

