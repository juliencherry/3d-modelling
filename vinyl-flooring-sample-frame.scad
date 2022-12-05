$fn = 100;

module rounded_square(size, corner_radius) {
    translate([corner_radius, corner_radius, 0]) minkowski() {
        square(size - corner_radius * 2, size - corner_radius * 2);
        circle(corner_radius);
    }
}

size = 4;
height = 1/4;
border_width = 1/4;
base_thickness = 1/16;

translate([border_width, border_width, 0]) difference() {
    linear_extrude(base_thickness + height) offset(border_width) rounded_square(size, border_width / 2);
    translate([0, 0, base_thickness]) cube([size, size, height * 2]);
}