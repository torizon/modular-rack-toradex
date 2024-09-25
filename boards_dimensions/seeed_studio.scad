include <../global_measures.scad>

internal_length = 111;
internal_width = 111;

start_inside_cube_x = (external_length - internal_length)/2;
start_inside_cube_y = (external_width - internal_width)/2;

base_thickness = 6;
base_size = 10;
left_distance_front = 5.5;
right_distance_front = 5.5;
left_distance_back = 5.5;
right_distance_back = 5.5;
internal_lateral_thickness = 5.5;

foot_size = 8.5;
foot_height = 8.5;
internal_heigth = standard_height/2;

// TODO - This measures was not verified
screw_distance_x = 4.75;
screw_distance_y = 4.75;
