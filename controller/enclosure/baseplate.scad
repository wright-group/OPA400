include <constants.scad>

module baseplate()
{
    difference(){
        translate([0,0,-base_height])
        cube([length, width, base_height]);
        
        // Raspberry pi mounting holes
        y_offset = 31;
        for (x=[length/2-49/2, length/2+49/2])
            for(y=[y_offset, y_offset+58])
                translate([x,y])
                cylinder(d=through_4_40, h=base_height*3, center=true);
        
        // Uprights
        for (x=[extrusion_width/2, length-extrusion_width/2])
            for(y=[extrusion_width/2, width-extrusion_width/2])
                translate([x,y])
                cylinder(d=through_3_mm, h=base_height*3, center=true);
            
        // Power supplies
        for(y=[2.5:1.5:6.5])
            translate([length/2-0.5*inch, width-y*inch, 0])
        {
            for (x=[62.5-39.1-11.5, 62.5-11.5])
                translate([x, 28-15.1])
                    cylinder(d=through_3_mm, h=base_height*3, center=true);
        }
        
    }
}


baseplate();