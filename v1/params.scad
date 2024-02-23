thickness=1;
clearance=0.3;

// params for the central screw
inner_tube_length=60;
inner_tube_radius=20;
rear_axis_radius=3;
rear_axis_length=10;
rear_axis_padding=1;
front_axis_padding=1;

// shell
cylinder_radius_margin=0.5;
shell_length = inner_tube_length + rear_axis_padding + front_axis_padding + thickness*2;
shell_radius_inner = inner_tube_radius + cylinder_radius_margin;
shell_radius_outer = shell_radius_inner + thickness;
input_hole_length=25;
input_hole_offset=5;
input_hole_width=inner_tube_radius*1;
bottom_hole_length=15;
bottom_hole_width=inner_tube_radius*0.7;

// shell base
shell_plate_width = inner_tube_radius * 1.5 + thickness * 2;
shell_plate_length = inner_tube_length + front_axis_padding + rear_axis_padding + thickness * 2;
shell_plate_thickness = 3;
shell_plate_wing_height = 10;


// middle plate
motor_plate_bottom_extra=12;


// bottom adapter
bottom_offset=-bottom_hole_length/3;


// motor holder
motor_support_width=50;
motor_support_height=51;
motor_support_length=54;
motor_support_hole_length=bottom_hole_length;
motor_support_hole_width=4;
motor_support_motor_hole_dist_top=9.5;
motor_support_motor_hole_center_height=motor_support_height-motor_support_motor_hole_dist_top-motor_disk_diameter/2;




reservoirH=30;

// connector male/female
plug_diameter_max=67.3;
plug_diameter_min=62;
plug_holders_diameter=64.3;
plug_holders_width=15;
plug_holders_height=1.5;
plug_guide_diameter=66.85;
plug_guide_width=16;
plug_wall_depth=1.5;
plug_height_male=17;
plug_height_female=14.5;
plug_female_offset = plug_wall_depth + 0.5;
