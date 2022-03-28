

include <3d_printed_parts/TL_stage_NEMA_11.scad>;


module external_parts()
{
    color("grey"){
    translate([-stage_length, 0, 0]){
        import("machined_parts/TL_PT1B_pad.stl");
    }
    
    // The stage (provided by TL, converted from STEP to STL in freecad
    translate([20.3-stage_length,11.8,platform_height+stage_pad]) rotate([90,0,-90]) #import("purchased_parts/PT1B.stl");
    
    // Adapter for flex coupler to thumbscrew
    translate([147-stage_length, width/2, center_axis]) rotate([0,-90,0]){
//        include <machined_parts/TL_stage_NEMA_11_adapter.scad>;
    }
    
    // Flexible coupler
    translate([148-stage_length, width/2, center_axis]) rotate([0,90,0]){
        #include <purchased_parts/flex_coupling_5_8.scad>;
    }
    
    // Rough NEMA 11 motor (tried using MCAD/motors, did not work as expected)
    #translate([motor_mount_x+motor_mount_width-3, width/2, center_axis]) rotate([0,-90,0]){
        cylinder(r=4.9/2, h=16);
        translate([0, 0, -2])cylinder(r=10.9, h=2);
        translate([0, 0, -2.1-inch]) cube([28,28,2*inch], center=true);
    }
    
    // Optical interrupt OMRON SX3009
    #translate([0.5*inch+2, width+1, total_height-13]){
        cube([11,8,34]);
        for (z=[6,16.25]) translate([0,-10.6,z]) cube([7, 10.6, 4.75]);
    }
    // Mirror mount adapter
    translate([-2*inch, 3.5*inch, total_height]) rotate([0, 0, 180]) {
        include <machined_parts/Mirror_mount_pad.scad>;
            mirrors = "thorlabs";
    if (mirrors == "newport"){
        translate([1.5*inch, 3*inch, 29])
        rotate([0,0,180-45]) translate([-96, -128.5, -128]) #import("purchased_parts/Newport_ultima.stl");
        translate([1.5*inch, 1*inch, 29])
        rotate([0,0,180+45]) translate([-96, -128.5, -128]) #import("purchased_parts/Newport_ultima.stl");
    }
    else if (mirrors == "thorlabs"){
        translate([1.5*inch, 3*inch, 29])
        rotate([0,0,180-45]) translate([2,0]) rotate([180, 0, 90]) #import("purchased_parts/KM100.stl");
        translate([1.5*inch, 1*inch, 29])
        rotate([0,0,180+45]) translate([2,0]) rotate([180, 0, 90]) #import("purchased_parts/KM100.stl");
    }
    }
}
}

translate([0, -3*inch, 0])
external_parts();

