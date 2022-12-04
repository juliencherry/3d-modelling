include <clip.scad>

$fn=100;

module railing_clip(clip_inner_diameter, clip_height, clip_thickness) {
    clip_outer_diameter = clip_inner_diameter + clip_thickness * 2;
    
    translate([0, clip_outer_diameter * 1.5, -clip_outer_diameter / 2]) rotate([0, 90, 0]) clip(clip_inner_diameter, clip_height, clip_thickness, squared=true);
}

module frame(dimensions=[0, 0, 0], inset_dimensions=[0, 0, 0]) {
    difference() {
        cube([dimensions.x, dimensions.y, dimensions.z]);    
        translate([(dimensions.x - inset_dimensions.x) / 2, -0.5, (dimensions.z - inset_dimensions.z) / 2]) cube([inset_dimensions.x, inset_dimensions.y + 0.5, inset_dimensions.z]);
    }
}

module velux_keypad_holder() {
    keypad_width = 80;
    keypad_depth = 14.5;
    keypad_height = 80;
    distance_between_bars = 139;
       
    clip_inner_diameter = 15.5;
    clip_height = 15.5;
    clip_thickness = 2;
    clip_outer_diameter = clip_inner_diameter + clip_thickness * 2;
    distance_between_clips = 139 - clip_thickness * 2;
    
    holder_thickness = 5;
    holder_width = keypad_width + holder_thickness * 2;
    holder_depth = keypad_depth + holder_thickness;
    holder_height = distance_between_clips + clip_outer_diameter * 2;
    
    translate([0, 0, (distance_between_clips - holder_height) / 2]) frame([holder_width, holder_depth, holder_height], [keypad_width, keypad_depth, keypad_height]);
    
    for(translateX = [0, holder_width - clip_inner_diameter]) {
        for(translateZ = [0, distance_between_clips + clip_outer_diameter]) {
            translate([translateX, 0, translateZ]) railing_clip(clip_inner_diameter, clip_height, clip_thickness);
        }
    }
}

velux_keypad_holder();