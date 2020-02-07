
// Units are mm, conversion for when inch is wanted
inch = 25.4;
PREVIEW_OTHER_PARTS = false;
$fn=100;
// length of platform
length = 4*inch;
stage_length = 4 * inch;
width = 3*inch;
platform_height = 5;
TL_stage_height = 13/16*inch;
total_height = 1.25*inch;
quarter20_through = 0.257*inch / 2;
quarter20_counterbore = 6;
motor_mount_width = 0.25*inch;
motor_mount_x = 2.875*inch;



stage_pad = total_height - platform_height - TL_stage_height;
center_axis = 9.5+ stage_pad+platform_height;

difference(){
union(){
    platform();
    de_9_housing();
    nema_11_mount();
    optical_interrupt_mount();
    if (PREVIEW_OTHER_PARTS) external_parts();
}
//cube([length*3, width, 100], center=true);
}

module platform(){
    difference(){
        // Base Platform
        cube([length, width, platform_height]);
        for (y=[.5,width/inch -0.5]){
            for(x=[.5,floor(length/inch) - 0.5]){
                translate([x*inch,y*inch, .125*inch]) union(){
                    cylinder(r=quarter20_through, h=inch, center=true);
                    cylinder(r=quarter20_counterbore, h=20);
                }
            }
        }
    }
}


// NEMA 11 motor mount bracket
module nema_11_mount(){
translate([motor_mount_x, width/4, platform_height])
    difference(){
        union(){
            cube([motor_mount_width, width/2, total_height]);
            fillet_box(motor_mount_width, width/2, 4);
        }
        
        translate([0,width/4, center_axis - platform_height])
            rotate([0, 90, 0])
                union(){
                    cylinder(h=3*motor_mount_width, r=11, center=true);
                    for (xpos=[-11.5, 11.5]){
                        for (ypos=[-11.5, 11.5]){
                            translate([xpos, ypos, 0])
                               cylinder(h=3*motor_mount_width, r=2.7/2, center=true);
                            translate([xpos, ypos, 0])
                               cylinder(h=4, r=5.4/2, center=true); 
                            
                        }
                    }
                }
        translate([motor_mount_width+1.5, width/4, center_axis-platform_height])
            rotate([0,90,0])
            minkowski(){
                cube([27.5, 27.5, 4], center=true);
                cylinder(h=.1, r=1);
            }
    }
}
// DE-9 connector housing
module de_9_housing(){
translate([1.125*inch, 0, 0.25*inch])
    difference(){
        union(){
            cube([40, 14.5, 20]);
            fillet_box(40, 14.5, 5);
        }
        translate([20,-5,0])
            cube([80, 10, 10], center=true);
        translate([20,0, 10])
        union(){
            rotate([90, 0, 0])
            union(){
            // face plate
            minkowski(){
                cube([30, 12, 3], center=true);
                cylinder(h=.1, r=1);
            }
            // main body
            minkowski(){
                linear_extrude(50, center=true) polygon([[-19/2, 5],[19/2, 5],[16/2, -5],[-16/2, -5]]);
                cylinder(r=1.1);
            }
            // screw holes
            translate([-25/2, 0, 0])
                cylinder(h=12, r=1.25, center=true);
            translate([25/2, 0, 0])
                cylinder(h=12, r=1.25, center=true);
        }
        }
    }
}
// Optical interrupt bracket
module optical_interrupt_mount(){
translate([0.5*inch, width, 0])
    difference(){
        union(){
            xsize=15;
            ysize=8;
            cube([xsize, ysize, total_height + 24]);
            
            // Strain relief fillets
            translate([xsize/2, 0, platform_height]) rotate([90, 0,-90]) fillet(length=xsize);
            translate([0, 0, platform_height/2]) rotate([0, 0,90]) fillet(size=ysize, length=platform_height);
            translate([xsize, 0, platform_height/2]) rotate([0, 0,0]) fillet(size=ysize, length=platform_height);
        }
        
        translate([5.5, 4, total_height-13+2])
            rotate([90, 0, 0])
            union(){
                cylinder(h=4.1,r=2.05);
                translate([0, 23, 0])
                    union(){
                        cylinder(h=8.2,r=2.1, center=true);
                        translate([0,0,-4.1])
                        linear_extrude(3.5){
                            circle(7.2/2, $fn=6);
                        }
                    }
            }
    }
}

module fillet_shape(size=5){
    union(){
    difference(){
             square([size, size]);
             translate([size, size])
                circle(r=size);
            }
        }
    }
    
module fillet(size=5, length=100){
    //rotate([90,0,0])
    linear_extrude(length, center=true){
        //rotate([-90,0,0])
        fillet_shape(size);
    }
}

module fillet_box(x, y, size=5){
    translate([0, y/2]) rotate([90, 0,180]) fillet(size, y);
    translate([x, y/2]) rotate([90, 0,0]) fillet(size, y);
    translate([x/2, 0]) rotate([90, 0,-90]) fillet(size, x);
    translate([x/2, y]) rotate([90, 0,90]) fillet(size, x);
    intersection(){
        translate([-size/2,0]) rotate([90, 0,-90]) fillet(size, size);
        translate([0, -size/2]) rotate([90, 0,180]) fillet(size, size);
    }
    intersection(){
        translate([x+size/2,0]) rotate([90, 0,-90]) fillet(size, size);
        translate([x, -size/2]) rotate([90, 0,0]) fillet(size, size);
    }
    intersection(){
        translate([x+size/2,y]) rotate([90, 0,90]) fillet(size, size);
        translate([x, y+size/2]) rotate([90, 0,0]) fillet(size, size);
    }
    intersection(){
        translate([-size/2,y]) rotate([90, 0,90]) fillet(size, size);
        translate([0, y+size/2]) rotate([90, 0,180]) fillet(size, size);
    }
}

