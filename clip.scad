$fn = 100;

module stadium(radius, length) {
    translate([-length / 2, 0, 0]) hull() {
        circle(radius);
        translate([length, 0, 0]) circle(radius);
    }
}

module capsule(radius, length) {
    hull() {
        sphere(radius);
        translate([length, 0, 0]) sphere(radius);
    }
}

inner_diameter = 11;
inner_radius = inner_diameter / 2;
inner_length = inner_radius * 1.5;
border_size = 2;
outer_radius = inner_radius + border_size;
outer_length = inner_length;
height = 10;

linear_extrude(height, center=false, scale=1.25) {
    difference() {
        stadium(outer_radius, outer_length);
        stadium(inner_radius, inner_length);
    }
}
