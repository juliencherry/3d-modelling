$fn = 100;

module clip(inner_radius, outer_radius, height, thickness) {
    cutout_radius = thickness * 2;
    linear_extrude(height) difference() {
        circle(inner_radius + thickness);
        circle(inner_radius);
        translate([0, outer_radius - cutout_radius + thickness / 2, 0]) circle(thickness * 2);
    }
}

module peg(height, radius) {
    difference() {
        translate([radius, radius, 0]) cylinder(h = height, r = radius);
        translate([0, -radius, 0]) rotate([0, 45, 0]) cube(radius * 4);
        translate([0, -radius, height]) rotate([0, 45, 0]) cube(radius * 4);
    }
}

module attached_peg(length, radius, clip_inner_radius) {
    translate([radius, -clip_inner_radius, 0]) rotate([0, -45, 90]) peg(length, radius);
}

module hook(attachment_height, major_radius, minor_radius) {
    translate([0, -major_radius, 0]) rotate([-90, 0, 90]) {
        rotate_extrude(angle=180 + 45, convexity=10) translate([major_radius, 0]) circle(minor_radius);
        translate([major_radius, 0, 0]) rotate([90, 0, 0]) cylinder(r=minor_radius, h=attachment_height);
    }
}

module attached_hook(attachment_height, major_radius, minor_radius, clip_inner_radius, wire_radius) {
    translate([0, -clip_inner_radius - minor_radius, 0]) {
         hook(attachment_height, major_radius, minor_radius);
    }
}

module hanger(clip_inner_diameter, clip_thickness) {    
    clip_inner_radius = clip_inner_diameter / 2;
    clip_outer_radius = clip_inner_radius + clip_thickness;
    clip_outer_diameter = clip_outer_radius * 2;
    clip_height = clip_inner_diameter;
    
    attachment_rotation = 360 - 360 / 3;
    
    peg_length = 50;
    peg_radius = clip_thickness * 1.5;
    
    // rotate(a = attachment_rotation) attached_peg(peg_length, peg_radius, clip_inner_radius);
    // rotate(a = -attachment_rotation) attached_peg(peg_length, peg_radius, clip_inner_radius);
    
    hook_attachment_height = clip_height;
    hook_major_radius = peg_length / 2;
    hook_minor_radius = peg_radius;
    
    rotate(a = attachment_rotation) attached_hook(hook_attachment_height, hook_major_radius, hook_minor_radius, clip_inner_radius);
    rotate(a = -attachment_rotation) attached_hook(hook_attachment_height, hook_major_radius, hook_minor_radius, clip_inner_radius);
    
    clip(clip_inner_radius, clip_outer_radius, clip_height, clip_thickness); 
}

hanger(15.5, 2);