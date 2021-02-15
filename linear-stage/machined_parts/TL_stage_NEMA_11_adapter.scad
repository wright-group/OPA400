$fn=100;
module tl_key(){
    cylinder(r=3.5/2, h=16);
    cylinder(r=2/sqrt(3), h=18, $fn=6);
    translate([0,0,-12]) cylinder(r=4, h=12);
}

tl_key();