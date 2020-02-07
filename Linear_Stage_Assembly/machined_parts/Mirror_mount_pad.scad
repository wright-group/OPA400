inch=25.4;
$fn=100;
length = 2*inch;
width = 4*inch;
height = .25*inch;

difference(){
cube([length, width, height]);
    
for(x=[.5:length/inch]) for(y=[1:width/inch-1]) translate([x*inch, y*inch, height/2]) {
    cylinder(r=.257*inch/2, h=20, center=true);
    cylinder(r=6, h=height);
}
for(x=[1]) for(y=[1.5:width/inch-1]) translate([x*inch, y*inch, height/2]) {
    cylinder(r=.257*inch/2, h=20, center=true);
    cylinder(r=6, h=height);
}

for (face_to_screw=[(1.14 - 0.31)*inch+ 1, 16]){
echo(face_to_screw);

x = (1.5*inch-face_to_screw*sqrt(2)/2);
ys = [1*inch-face_to_screw*sqrt(2)/2, 3*inch+face_to_screw*sqrt(2)/2];

echo(x, ys);
echo(x/inch, ys/inch);

for(y=ys) translate([x, y, height/2]) {
    cylinder(r=.164*inch/2, h=20, center=true);
}
}
}

PREVIEW_OTHER_PARTS=false;
if(PREVIEW_OTHER_PARTS)
{
    
    mirrors = "thorlabs";
    if (mirrors == "newport"){
        translate([1.5*inch, 3*inch, 29])
        rotate([0,0,180-45]) translate([-96, -128.5, -128]) #import("../purchased_parts/Newport_ultima.stl");
        translate([1.5*inch, 1*inch, 29])
        rotate([0,0,180+45]) translate([-96, -128.5, -128]) #import("../purchased_parts/Newport_ultima.stl");
    }
    else if (mirrors == "thorlabs"){
        translate([1.5*inch, 3*inch, 29])
        rotate([0,0,180-45]) translate([2,0]) rotate([180, 0, 90]) #import("../purchased_parts/KM100.stl");
        translate([1.5*inch, 1*inch, 29])
        rotate([0,0,180+45]) translate([2,0]) rotate([180, 0, 90]) #import("../purchased_parts/KM100.stl");
    }
    
}