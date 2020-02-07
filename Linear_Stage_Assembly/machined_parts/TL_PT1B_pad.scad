
// Units are mm, conversion for when inch is wanted
inch = 25.4;
$fn=100;
stage_length = 3.875 * inch;
width = 3*inch;
TL_stage_height = 13/16*inch;
total_height = 1.25*inch;
quarter20_through = 0.257*inch / 2;
quarter20_counterbore = 6;

stage_pad = total_height - TL_stage_height;
echo(stage_pad/inch*16);
center_axis = 9.5 + stage_pad;

CORNER_SCREWS=false;

module pad(){
    difference(){
        // Thorlabs stage mount
        cube([stage_length, width, stage_pad]);
        
        if(CORNER_SCREWS){
        for (y=[.5,width/inch -0.5]){
            for(x=[.5, floor(stage_length/inch+.4) - 0.5]){
                translate([x*inch,y*inch, .125*inch]) union(){
                    cylinder(r=quarter20_through, h=inch, center=true);
                    cylinder(r=quarter20_counterbore, h=20);
                }
            }
        }
    }
        for(x=[1.5, 2.5]) translate([x*inch, width/2]) cylinder(r=quarter20_through, h=2*inch, center=true);
        translate([0,0,stage_pad])
        for(x=[1, 3]) translate([x*inch, width/2]) cylinder(r=1/16*inch, h=6, center=true);
    }
}

pad();