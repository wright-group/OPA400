include <constants.scad>

module dsub_housing(width=19){
    rotate([90, 0,0]){
    small_side = width - 3;
    screw_width = width + 6;
    union(){
            // face plate
            minkowski(){
                cube([width + 10, 12, 3], center=true);
                cylinder(h=.1, r=1);
            }
            // main body
            minkowski(){
                linear_extrude(50, center=true) polygon([[-width/2, 5],[width/2, 5],[small_side/2, -5],[-small_side/2, -5]]);
                cylinder(r=1.1);
            }
            // screw holes
            for (x=[-screw_width/2, screw_width/2]){
            translate([x, 0, 0])
                cylinder(h=20, r=1.25, center=true);
            }
        }
    }
}

module front_panel(){
    color("#0000cc"){
        translate([length/2, extrusion_width/2, height/2])
            difference(){
                union(){
                cube([length-extrusion_width-6, wall_thickness, height], center=true);
                    // pad wall thickness where connectors are
                    translate([0, wall_thickness, 5])
                     cube([length-2*inch, wall_thickness*2, height-1.5*inch], center=true);
                }
                //raspberry pi opening
                translate([0, 0, -height/2])
                
                minkowski(){
                cube([50, 4, 44],center=true);
                rotate([90, 0, 0]) cylinder(r=2, h=wall_thickness*2, center=true);
                }
                
                // DSub connectors
                translate([20,-wall_thickness/2,-15]) dsub_housing();
                translate([-20,-wall_thickness/2,-15]) dsub_housing();
                translate([0,-wall_thickness/2,5]) dsub_housing(41);
                translate([0,-wall_thickness/2,25]) dsub_housing(41);
            }
    }
}

rotate([90,0,0])
translate([-length/2, -extrusion_width/2, -height/2])
    front_panel();
