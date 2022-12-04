module clip(inner_diameter, height, thickness, squared=false) {
    inner_radius = inner_diameter / 2;
    outer_radius = inner_radius + thickness;
    outer_diameter = outer_radius * 2;
    cutout_radius = thickness * 2;

    linear_extrude(height) {
        if(squared) {
            difference() {
                translate([0, -outer_radius / 2, 0]) square([outer_diameter, outer_radius], true);
                circle(inner_radius);
            }
        }
        difference() {
            circle(inner_radius + thickness);
            circle(inner_radius);
            translate([0, inner_radius - cutout_radius + thickness * 1.5, 0]) circle(thickness * 2);
        }
   }
}