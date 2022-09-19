include <../params.scad>

translate([0,0,-plug_holders_height-0.2])
connector_male();

connector_female();



module connector_male() {
    connector_shape(plug_height_male, 0);
    holders(plug_height_male);
}

module connector_female() {
    $fn=100;
    
    offset = plug_wall_depth + 0.8;
    connector_shape(plug_height_female, offset);
}

module connector_shape(h, offset) {
    $fn=100;
    
    difference() {
        union() {
            main_cone_outer(h, offset);
            guide_shape(h, offset);
        }
        
        main_cone_inner(h, offset);
        
        guide_shape(h, offset, -plug_wall_depth, 2);
    }
}


module guide_shape(connector_h, offset=0, bonus_xy=0, bonus_h=0) {
    x = plug_guide_diameter + offset + bonus_xy;
    y = plug_guide_width + offset+ bonus_xy;
    h = connector_h + bonus_h;
    
    translate([0,0,h/2-bonus_h/2])
    cube([x, y, h], center=true);
}

module main_cone_inner(h, offset=0) {
    inner_dmax = plug_diameter_max + offset - plug_wall_depth;
    inner_dmin = plug_diameter_min + offset - plug_wall_depth;

    translate([0,0,-0.01])
    half_cone_shape(inner_dmax, inner_dmin, h+0.02);
}

module main_cone_outer(h, offset) {
    half_cone_shape(plug_diameter_max + offset, plug_diameter_min + offset, h);  
}

module half_cone_shape(dmax, dmin, height) {
    hull() {
        translate([0,0,height])
        cylinder(0.01, r=dmax/2);
        
        cylinder(0.01, r=dmin/2);
    }
}

module holders(connector_h) {
    difference() {
        // base circle
        color("#a00")
        cylinder(plug_holders_height, r=plug_holders_diameter/2);

        // cut right
        translate([plug_holders_diameter/2+plug_holders_width/2,0,plug_holders_height-0.01])
        cube([plug_holders_diameter, plug_holders_diameter, plug_holders_height*2], center=true);
        
        // cut left
        translate([-plug_holders_diameter/2-plug_holders_width/2,0,plug_holders_height-0.01])
        cube([plug_holders_diameter, plug_holders_diameter, plug_holders_height*2], center=true);
        
        // cut middle
        main_cone_inner(connector_h);
  
        // cut angles
        translate([0,0,-0.01])
        difference() {
            translate([0,0,plug_holders_height])
            cube([plug_holders_diameter, plug_holders_diameter, plug_holders_height*2], center=true);
            
            s = 0.83;
            scale([s,s,1])
            translate([0,0,plug_holders_height*2/2])
            rotate([0,0,45])
            cube([plug_holders_diameter, plug_holders_diameter, plug_holders_height*2.5], center=true);
        }
    }
}
