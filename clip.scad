module clip(inner_diameter, height, thickness) {
    inner_radius = inner_diameter / 2;
    cutout_radius = thickness * 2;

    linear_extrude(height) difference() {
        circle(inner_radius + thickness);
        circle(inner_radius);
        translate([0, inner_radius - cutout_radius + thickness * 1.5, 0]) circle(thickness * 2);
    }
}