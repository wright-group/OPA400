inch=25.4;

extrusion_width = 14.9;
length = 5*inch;
height = 4*inch;
width=10*inch;
base_height = 0.125*inch;


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
    cube([length, width, base_height]);
}

module frame(){
    baseplate();
    
    for (x=[0, length-extrusion_width])
    {
        for (y=[0, width-extrusion_width])
            translate([x,y])
                linear_extrude(height)extrusion_shape();
        translate([x,extrusion_width, height+extrusion_width]){
            rotate([-90, 0, 0])
                linear_extrude(width-2*extrusion_width)extrusion_shape();
        }
    }
    for (y=[0, width-extrusion_width]){
        translate([extrusion_width,y, height+extrusion_width]){
            rotate([0, 90, 0])
                linear_extrude(length-2*extrusion_width)extrusion_shape();
        }
    }
}

module clear_panels(){
    color("#ffffff22"){
        for (x=[extrusion_width/2, length-extrusion_width/2])
            translate([x, width/2, height/2+base_height-1])
                cube([3, width-extrusion_width-6, height+4], center=true);
        translate([length/2, width/2, height+extrusion_width/2])
            cube([length-extrusion_width-6, width-extrusion_width-6, 3], center=true);
    }
}

module front_panel(){
    color("#0000cc77"){
        translate([length/2, extrusion_width/2, height/2+base_height-1])
            difference(){
                cube([length-extrusion_width-6, 3, height+4], center=true);
                translate([0, 0, -height/2])
                cube([55, 4, 50],center=true);
            }
    }
}

module back_panel(){
    color("#0000cc77"){
        translate([length/2, width - extrusion_width/2, height/2+base_height-1])
            difference(){
                cube([length-extrusion_width-6, 3, height+4], center=true);
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
translate([length/2-1*inch, width-dist*inch, base_height])
power_supply();

translate([length/2, 50, 1+base_height+.25*inch])
{
rotate([90,0,-90]){
#import ("rpi4.stl"); 
for (y=[0.5: 0.625: 3])
    translate([-12, y*inch, 0])
        #cube([65, 2, 56], center=true);
}
}

frame();
//clear_panels();
front_panel();
back_panel();