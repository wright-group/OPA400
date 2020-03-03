inch=25.4;

extrusion_width = 14.9;
length = 5*inch;
height = 4.5*inch;
width=10*inch;
base_height = 0.125*inch;
wall_thickness = 3;
through_4_40 = 3.45;
through_3_mm = 3.1;
$fn=100;

module extrusion_shape()
{
    difference(){
        square(extrusion_width);
        translate([extrusion_width/2, extrusion_width/2]){
        square(2.6, center=true);
        for (r =[0:90:270])
            rotate(r){
                translate([5.3, 0]){
                    square([2.6, 5.9], center=true);
                    square([6, 3.1], center=true);
                }
                translate([5.3, 5.3]){
                    square(2, center=true);
                }
            }
        }
    }
}

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
                cylinder(d=through_4_40, h=base_height*3, center=true);
            
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

module frame(){
    baseplate();
    
    for (x=[0, length-extrusion_width])
    {
        for (y=[0, width-extrusion_width])
            translate([x,y])
        {
                echo ("Extrusion: ", height, "mm =", height/inch, " inch");
                linear_extrude(height)extrusion_shape();
        }
        
        translate([x,extrusion_width, height+extrusion_width]){
            rotate([-90, 0, 0])
            {
                dist = width-2*extrusion_width;
                linear_extrude(dist)extrusion_shape();
                echo ("Extrusion: ", dist, "mm = ", dist/inch, "inch");
            }
        }
    }
    for (y=[0, width-extrusion_width]){
        translate([extrusion_width,y, height+extrusion_width]){
            rotate([0, 90, 0])
            {
                dist = length-2*extrusion_width;
                linear_extrude(dist)extrusion_shape();
             echo ("Extrusion: ", dist, "mm = ", dist/inch, "inch");
            }
        }
    }
}

module clear_panels(){
    color("#ffffff22"){
        for (x=[extrusion_width/2, length-extrusion_width/2])
            translate([x, width/2, height/2+base_height-1])
                cube([wall_thickness, width-extrusion_width-6, height+4], center=true);
        translate([length/2, width/2, height+extrusion_width/2])
            cube([length-extrusion_width-6, width-extrusion_width-6, wall_thickness], center=true);
    }
}

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
        translate([length/2, extrusion_width/2, height/2+base_height-1])
            difference(){
                union(){
                cube([length-extrusion_width-6, wall_thickness, height+4], center=true);
                    // pad wall thickness where connectors are
                    translate([0, wall_thickness, 5])
                     cube([length-2*inch, wall_thickness*2, height-2*inch], center=true);
                }
                // Corners nibbled away
                for(x=[-length/2+extrusion_width/2, length/2-extrusion_width/2])
                    translate([x, 0, height/2]) cube([15,5,5], center=true);
                //raspberry pi opening
                translate([0, 0, -height/2])
                
                minkowski(){
                cube([50, 4, 40],center=true);
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

module back_panel(){
    color("#0000cc77"){
        translate([length/2, width - extrusion_width/2, height/2+base_height-1])
            difference(){
                cube([length-extrusion_width-6, wall_thickness, height+4], center=true);
                // Corners nibbled away
                for(x=[-length/2+extrusion_width/2, length/2-extrusion_width/2])
                    translate([x, 0, height/2]) cube([15,5,5], center=true);
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
}

module power_supply(){
    cube([62.5, 28, 51]);
    translate([-13, 5, 10])
        cube([13, 10, 40]);
}

color("grey")
for(dist=[2.5:1.5:6.5])
translate([length/2-0.5*inch, width-dist*inch, 0])
#power_supply();

translate([length/2, 50, 1+.25*inch])
{
rotate([90,0,-90]){
#import ("rpi4.stl"); 
for (y=[0.5: 0.625: 3])
        translate([-10, y*inch, 0])
        #cube([65, 2, 56], center=true);
}
}

frame();
//clear_panels();
front_panel();
back_panel();