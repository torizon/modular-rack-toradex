// Board dimensions
internal_length = 72.5;
internal_width = 100.5;

external_length = 140;
external_width = 140;

// Espessura das paredes e base
start_inside_cube_x = (external_length - internal_length)/2;
start_inside_cube_y = (external_width - internal_width)/2;
base_thickness = 5;


// Total height of the support
total_height = 40;

base_size = 10;

left_distance = 6;
right_distance = 6;
wall_thickness_corner = 10;

distance_x_hole = 15;
distance_y_hole = 1.5;

hole_width = 2;
hole_heigth = 6;

space_beetween_hole_pin = 0.1;

wall_thickness = 5;

// Função para criar o suporte com a parte da frente ajustada
module support() {
    // External box
    difference() {
        // Caixa externa
        translate([2, 2, 0])
            linear_extrude(total_height)offset(r=2)square([external_length-4, external_width-4]);
        // cube([external_length, external_width, total_height]);

        // Internal box
        translate([start_inside_cube_x, start_inside_cube_y, base_thickness])
            cube([internal_length, internal_width, total_height - base_thickness]);
        
        // Retira parede esquerda
        translate([0, wall_thickness, base_thickness])
            cube([external_length, start_inside_cube_y - 2 * wall_thickness, total_height - base_thickness]);

        // Retira parede direita
        translate([0, start_inside_cube_y + internal_width + wall_thickness, base_thickness])
            cube([external_length, start_inside_cube_y - 2 * wall_thickness, total_height - base_thickness]);

        // Retira parede cima
        translate([0, start_inside_cube_y - wall_thickness, base_thickness])
            cube([start_inside_cube_x - wall_thickness, internal_width + 2 * wall_thickness, total_height - base_thickness]);

        // Retira parede baixo
        translate([external_width - start_inside_cube_x + wall_thickness, start_inside_cube_y - wall_thickness, base_thickness])
            cube([start_inside_cube_x, internal_width + 2 * wall_thickness, total_height - base_thickness]);
        
        // Internal support for board floor
        translate([start_inside_cube_x+base_size, start_inside_cube_y+base_size])
            cube([internal_length-2*base_size, internal_width-2*base_size, total_height - base_thickness]);

        // Retira as paredes da frente
        translate([start_inside_cube_x + internal_length, start_inside_cube_y+left_distance, base_thickness])
            cube([start_inside_cube_x, internal_width - left_distance - right_distance, total_height - base_thickness]);

        // Retira a parte de trás
        translate([0, start_inside_cube_y + wall_thickness_corner, base_thickness])
            cube([internal_length - 2 * wall_thickness_corner, internal_width - 2 * wall_thickness_corner, total_height - base_thickness]);

        // Faz o buraco para caber o pino no lado esquerdo
        translate([distance_x_hole, distance_y_hole, 0])
            cube([external_length - 2 * distance_x_hole, hole_width, hole_heigth]);

        // Faz o buraco para caber o pino no lado direito
        translate([distance_x_hole, external_width - distance_y_hole - hole_width, 0])
            cube([external_length - 2 * distance_x_hole, hole_width, hole_heigth]);
    }

    // Faz o pino superior esquerdo
        translate([distance_x_hole + space_beetween_hole_pin, distance_y_hole + space_beetween_hole_pin, total_height])
            cube([external_length - 2 * distance_x_hole - 2 * space_beetween_hole_pin, hole_width - 2 * space_beetween_hole_pin, hole_heigth - space_beetween_hole_pin]);
    
    // Faz o pino superior direito
        translate([distance_x_hole + space_beetween_hole_pin, external_width - distance_y_hole - 2 * space_beetween_hole_pin - hole_width, total_height])
            cube([external_length - 2 * distance_x_hole - 2 * space_beetween_hole_pin, hole_width - 2 * space_beetween_hole_pin, hole_heigth - space_beetween_hole_pin]);
}

// Desenhar o suporte
support();
