thickness=2;

// params for the central cylinder
inner_tube_length=50;
inner_tube_radius=20;

cylinder_radius_margin=0.5;

rear_axis_radius=3;
rear_axis_length=10;
rear_axis_padding=1;
front_axis_padding=1;

// params for holes in the central cylinder
hole_depth=inner_tube_radius-5;
hole_length=inner_tube_length-1;
hole_width=inner_tube_radius*0.7;
bottom_hole_width=inner_tube_radius*0.7;

// motor
motor_total_length=71.35;
motor_block_length=47.3;
motor_block_side=42.3;
motor_block_flat_diameter=53.6;
motor_block_and_disk_length=49;
motor_disk_diameter=22;
motor_disk_length=motor_block_and_disk_length - motor_block_length;
motor_axis_length=motor_total_length - motor_block_and_disk_length;
motor_axis_diameter=5;
motor_axis_diameter_flat=4.5;
motor_axis_radius=motor_axis_diameter / 2;
motor_axis_radius_flat=motor_axis_diameter_flat - motor_axis_radius;

// motor holder
motor_support_width=50;
motor_support_height=51;
motor_support_length=54;
motor_support_hole_length=33.5;
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
