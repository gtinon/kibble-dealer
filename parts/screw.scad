include <../params.scad>

use <utils.scad>
use <motor.scad>
use <shell.scad>

// screw params
height = inner_tube_length - clearance*2;
outerRadius = inner_tube_radius-3;
innerRadius = rear_axis_radius*2;
top_padding = 8;
threadCrestH = 1;
threadCrestSpacing = 15;


// inner stuff
crestCount = (height-top_padding)/threadCrestSpacing;
threadBaseW = innerRadius;
threadBaseOffset = 0;

// debug
cut([0,-0.01,0])
infinite_screw();


module infinite_screw() {
    difference() {
        infinite_screw_without_axis_holes();

        // motor axis hole
        color("#00ff00")
        translate([0,0, motor_axis_length - thickness - front_axis_padding + clearance*2])
        rotate([90,0,0])
        motor_axis(radiusPadding=clearance);

        // top axis hole
        color("#00ff00")
        translate([0,0,height+0.001])
        rotate([90,0,0])
        rear_axis(clearance + 0.1);
    }
}

module infinite_screw_without_axis_holes() {
    linear_extrude(height-top_padding, twist=180 * crestCount, $fn=128){
        union(){
            circle(r=innerRadius, $fn=64);
            polygon([[outerRadius,-threadCrestH/2],
                    [outerRadius,threadCrestH/2],
                    [threadBaseOffset,threadBaseW],
                    [threadBaseOffset,-threadBaseW]]);
            polygon([[-outerRadius,-threadCrestH/2],
                    [-outerRadius,threadCrestH/2],
                    [-threadBaseOffset,threadBaseW],
                    [-threadBaseOffset,-threadBaseW]]);
        }
    }
    translate([0,0,height-top_padding])
    cylinder(top_padding,r=innerRadius,center=false, $fn=64);

    cylinder(1,r=inner_tube_radius,center=false, $fn=64);
}
