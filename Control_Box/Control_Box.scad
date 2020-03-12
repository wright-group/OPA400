
include <constants.scad>

use <baseplate.scad>
use <clear_panels.scad>
use <extrusion.scad>
use <front_panel.scad>
use <back_panel.scad>

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
    }
}



module power_supply(){
    cube([62.5, 28, 51]);
    translate([-13, 5, 10])
        cube([13, 10, 40]);
}

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
front_panel();
back_panel();
clear_panels();

