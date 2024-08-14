// Board dimensions
internal_length = 80;
internal_width = 50;

external_length = 140;
external_width = 140;

// Espessura das paredes e base
start_inside_cube_x = (external_length - internal_length)/2;
start_inside_cube_y = (external_width - internal_width)/2;
base_thickness = 5;


// Total height of the support
total_height = 40;

base_size = 10;

left_distance = 15;
right_distance = 6;
wall_thickness_corner = 10;

hole_width = 2;
hole_heigth = 6;

wall_thickness = 6;

distance_x_hole = 1.6 * wall_thickness;
distance_y_hole = (wall_thickness - hole_width)/2;

space_beetween_hole_pin = 0.15;

module support() {
    // External box
    difference() {
        cube([external_length, external_width, total_height]);

        // Internal box
        translate([start_inside_cube_x, start_inside_cube_y, base_thickness])
            cube([internal_length, internal_width, total_height - base_thickness]);
        
        // Remove left wall
        translate([0, wall_thickness, base_thickness])
            cube([external_length, start_inside_cube_y - 2 * wall_thickness, total_height - base_thickness]);

        // Remove right wall
        translate([0, start_inside_cube_y + internal_width + wall_thickness, base_thickness])
            cube([external_length, start_inside_cube_y - 2 * wall_thickness, total_height - base_thickness]);

        // Remove back wall
        translate([0, wall_thickness, base_thickness])
            cube([start_inside_cube_x - wall_thickness, external_width - 2*wall_thickness, total_height - base_thickness]);

        // Remove front wall
        translate([external_width - start_inside_cube_x + wall_thickness, wall_thickness, base_thickness])
            cube([start_inside_cube_x - wall_thickness, external_width - 2*wall_thickness, total_height - base_thickness]);
        
        // Internal hole on the floor for board
        translate([start_inside_cube_x+base_size, start_inside_cube_y+base_size])
            cube([internal_length-2*base_size, internal_width-2*base_size, total_height - base_thickness]);

        // Remove front wall on internal box
        translate([start_inside_cube_x + internal_length, start_inside_cube_y + left_distance, base_thickness])
            cube([wall_thickness, internal_width - left_distance - right_distance, total_height - base_thickness]);

        // Remove back wall on internal box
        translate([start_inside_cube_x - wall_thickness, start_inside_cube_y + wall_thickness_corner, base_thickness])
            cube([wall_thickness, internal_width - 2*wall_thickness_corner, total_height - base_thickness]);

        if (start_inside_cube_y - wall_thickness > wall_thickness){
            // Remove left wall on internal box
            translate([start_inside_cube_x + wall_thickness_corner, start_inside_cube_y - wall_thickness, base_thickness])
                cube([internal_length - 2*wall_thickness_corner, wall_thickness, total_height - base_thickness]);

            // Remove right wall on internal box
            translate([start_inside_cube_x + wall_thickness_corner, start_inside_cube_y + internal_width, base_thickness])
                cube([internal_length - 2*wall_thickness_corner, wall_thickness, total_height - base_thickness]);

            // Remove roof of internal box
            translate([start_inside_cube_x - wall_thickness, start_inside_cube_y - wall_thickness, base_thickness + total_height/2])
                cube([internal_length + 2*wall_thickness, internal_width + 2*wall_thickness, total_height/2]);
        }

        else{
            // Remove left wall on internal box
            translate([start_inside_cube_x + wall_thickness_corner, wall_thickness, base_thickness])
                cube([internal_length - 2*wall_thickness_corner, wall_thickness, total_height - base_thickness]);

            // Remove right wall on internal box
            translate([start_inside_cube_x + wall_thickness_corner, external_width - 2*wall_thickness, base_thickness])
                cube([internal_length - 2*wall_thickness_corner, wall_thickness, total_height - base_thickness]);

            // Remove roof of internal box
            translate([start_inside_cube_x - wall_thickness, wall_thickness, base_thickness + total_height/2])
                cube([internal_length + 2*wall_thickness, external_width - 2*wall_thickness, total_height/2]);
        }

        // Hole on the floor, left side
        translate([distance_x_hole, distance_y_hole, 0])
            cube([external_length - 2 * distance_x_hole, hole_width + 2*space_beetween_hole_pin, hole_heigth]);

        // Hole on the floor, right side
        translate([distance_x_hole, external_width - distance_y_hole - hole_width, 0])
            cube([external_length - 2 * distance_x_hole, hole_width + 2*space_beetween_hole_pin, hole_heigth]);

        // Hole on the front, left side
        translate([external_length - hole_heigth - space_beetween_hole_pin, distance_y_hole, wall_thickness])
            cube([external_length - hole_heigth - space_beetween_hole_pin, hole_width + 2*space_beetween_hole_pin, total_height - 2*wall_thickness]);

        // Hole on the front, right side
        translate([external_length - hole_heigth - space_beetween_hole_pin, external_width - distance_y_hole - 2*space_beetween_hole_pin - hole_width, wall_thickness])
            cube([external_length - hole_heigth - space_beetween_hole_pin, hole_width + 2 * space_beetween_hole_pin, total_height - 2*wall_thickness]);
    }

    // Pin on roof, left side
        translate([distance_x_hole + space_beetween_hole_pin, distance_y_hole + space_beetween_hole_pin, total_height])
            cube([external_length - 2*distance_x_hole - 2*space_beetween_hole_pin, hole_width, hole_heigth - space_beetween_hole_pin]);
    
    // Pin on roof, right side
        translate([distance_x_hole + space_beetween_hole_pin, external_width - distance_y_hole - space_beetween_hole_pin - hole_width, total_height])
            cube([external_length - 2*distance_x_hole - 2*space_beetween_hole_pin, hole_width, hole_heigth - space_beetween_hole_pin]);
    
    // Pin on back, left side
        translate([-(hole_heigth - space_beetween_hole_pin), distance_y_hole + space_beetween_hole_pin, wall_thickness + space_beetween_hole_pin])
            cube([hole_heigth - space_beetween_hole_pin, hole_width, total_height - 2*wall_thickness - space_beetween_hole_pin]);

    // Pin on back, right side
        translate([-(hole_heigth - space_beetween_hole_pin), external_width - distance_y_hole - space_beetween_hole_pin - hole_width, wall_thickness + space_beetween_hole_pin])
            cube([hole_heigth - space_beetween_hole_pin, hole_width, total_height - 2*wall_thickness - space_beetween_hole_pin]);
}

support();
