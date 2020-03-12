include <constants.scad>

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