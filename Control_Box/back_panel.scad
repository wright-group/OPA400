include <constants.scad>

module back_panel(){
    translate([length/2, width - extrusion_width/2, height/2])
    {
        
        color("#0000cc"){
            difference(){
                cube([length-extrusion_width-6, wall_thickness, height], center=true);
               
                // Power entry
                translate([-length/2 + 40, 0, -height/2+20])
                {
                    cube([28, wall_thickness*2, 31], center=true);
                    translate([36/2, 0, 0]) rotate([90, 0, 0])cylinder(d=3.5, h=wall_thickness *2, center=true);
                    translate([-36/2, 0, 0]) rotate([90, 0, 0])cylinder(d=3.5, h=wall_thickness *2, center=true);
                }
                //Switch
                translate([-length/2 + 40, 0, height/2-25])
                {
                    cube([22, wall_thickness*2, 30], center=true);
                }
            }
        }
            translate([40, wall_thickness/2, -height/4])
            rotate([90, 0, 180])
            linear_extrude(wall_thickness/2, center=true)
            
            scale(0.5)
            import("Group Logo.dxf", convexity=5);
        
    }
}

rotate([90,0,0])
translate([-length/2, -width + extrusion_width/2, -height/2])
back_panel();