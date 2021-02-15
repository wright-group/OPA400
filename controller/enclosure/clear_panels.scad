
include <constants.scad>

module clear_panels(){
    color("#ffffff22"){
        for (x=[extrusion_width/2, length-extrusion_width/2])
            translate([x, width/2, height/2])
            {
                cube([wall_thickness, width-extrusion_width-6, height], center=true);
                echo("Clear plastic wall:", width-extrusion_width-6, height, "mm");
                echo("Equivalent to wall:", (width-extrusion_width-6)/inch, height/inch, "in");
            }
        translate([length/2, width/2, height+wall_thickness/2])
        {
            difference(){
                cube([length, width, wall_thickness], center=true);
                echo("Clear plastic wall:", length, width, "mm");
                echo("Equivalent to wall:", length/inch, width/inch, "in");
                echo("With holes for 3mm screws in corners", extrusion_width/2, "mm = ", extrusion_width/2/inch, "in, square from each corner");
                for (x=[-length/2 + extrusion_width/2, length/2 - extrusion_width/2])
                    for(y=[-width/2 + extrusion_width/2, width/2 - extrusion_width/2])
                        translate([x,y])
                        cylinder(d=through_3_mm, h=wall_thickness*2, center=true);
            }
        }
    }
}

clear_panels();