NUM_SIDES=10;

BASE_SIZE=0.5;

BASE_HEIGHT=0.25;

WALL_SIZE=0.3;

WALL_HEIGHT=2.25;

CORNISE_HEIGHT=0.25;

BATTLEMENT_OUTER_SIZE=BASE_SIZE;

BATTLEMENT_OUTER_HEIGHT=0.1;

BATTLEMENT_INSIDE_SIZE=0.3;

RING_OUTER_HEIGHT=0.1;

RING_INSIDE_SIZE=0.3;

BATTLEMENT_RING_SEPARATION=2*BATTLEMENT_OUTER_HEIGHT;

STICK_OFFSET=0.4; 

STICK_SIZE=0.02;

CROSS_STICKS_IN_NET=10;

ROOF_STICK_SIZE=0.02;

ROOF_STICK_HEIGHT=0.575;

ROOF_STICK_OFFSET=0.4;

ROOF_STICKS_IN_ROOF=10;

CENTRAL_STICK_HEIGHT=0.875;

CENTRAL_STICK_SIZE=0.02;

BALL_SIZE=0.1;

ARRAY_BASE_CORRECTION=1;

CIRCLE_DEGREES=360;

function wall_levitation() = BASE_HEIGHT;

function cornise_levitation() = wall_levitation()+WALL_HEIGHT;

function battlement_outer_levitation() = cornise_levitation()+CORNISE_HEIGHT;
         
function battlement_inside_levitation() = battlement_outer_levitation()-0.25;
 
function ring_outer_levitation() = 
    battlement_outer_levitation()+
    BATTLEMENT_OUTER_HEIGHT+
    BATTLEMENT_RING_SEPARATION;


function ring_inside_levitation() = ring_outer_levitation()-0.3;

function inclined_stick_levitation() = battlement_outer_levitation()+BATTLEMENT_OUTER_HEIGHT;

function central_stick_levitation() = battlement_outer_levitation();

function ball_levitation() = central_stick_levitation()+CENTRAL_STICK_HEIGHT+0.05;

function roof_levitation() =
    ring_outer_levitation()+
    RING_OUTER_HEIGHT
    -0.025;

function cross_stick_rotation() = CIRCLE_DEGREES/CROSS_STICKS_IN_NET;

function roof_stick_rotation() = CIRCLE_DEGREES/ROOF_STICKS_IN_ROOF;


module base() {
    cylinder(r=BASE_SIZE, h=BASE_HEIGHT);
}

module wall() {
  	translate([0,0,wall_levitation()]) 
        cylinder(r=WALL_SIZE, h=WALL_HEIGHT);
}

module cornise() {
	translate([0,0,cornise_levitation()]) 
        cylinder(r1=WALL_SIZE, r2=BATTLEMENT_OUTER_SIZE, h=CORNISE_HEIGHT);
}

module battlement_outer() {
    translate([0,0,battlement_outer_levitation()]) 
        cylinder(r=BATTLEMENT_OUTER_SIZE, h=BATTLEMENT_OUTER_HEIGHT);
}

module battlement_inside() {
	translate([0,0,battlement_inside_levitation() ]) 
        cylinder(r=BATTLEMENT_INSIDE_SIZE, h=5*BATTLEMENT_OUTER_HEIGHT);
}

module battlement() {
	difference() {
		battlement_outer();
		battlement_inside();
	}    
}

module ring_outer() {
    translate([0,0,ring_outer_levitation()]) 
        cylinder(r=BASE_SIZE, h=RING_OUTER_HEIGHT);    
}

module ring_inside() {
    translate([0,0,ring_inside_levitation()]) 
        cylinder(r=RING_INSIDE_SIZE, h=5*RING_OUTER_HEIGHT);
}

module ring() {
	difference() {
		ring_outer();
		ring_inside();
	}    
    
}

module stick() {
    translate([STICK_OFFSET, 0, 0]) 
        circle(STICK_SIZE);     
}

module inclined_stick(twister_degrees) {
    translate([0, 0, inclined_stick_levitation()]) 
        linear_extrude(height=BATTLEMENT_RING_SEPARATION, twist=twister_degrees) 
           stick();    
}

module cross_stick() {
    inclined_stick(cross_stick_rotation());
    inclined_stick(-cross_stick_rotation());    
}

module net() {
	for(r = [0:CROSS_STICKS_IN_NET - ARRAY_BASE_CORRECTION]) {
		rotate(r*cross_stick_rotation(), [0,0,1])  
            cross_stick();
	}    
}

module central_stick() {
	translate([0,0,central_stick_levitation()]) 
        cylinder(r=CENTRAL_STICK_SIZE, h=CENTRAL_STICK_HEIGHT);
}

module ball() {
    translate([0,0,ball_levitation()]) 
       sphere(BALL_SIZE);
}

module roof_stick() {
    translate([ROOF_STICK_OFFSET, 0, roof_levitation()]) 
        rotate(45, [0,-1,0]) 
            cylinder(r=ROOF_STICK_SIZE, h=ROOF_STICK_HEIGHT);
}

module roof() {
 	for(r = [0:ROOF_STICKS_IN_ROOF-ARRAY_BASE_CORRECTION]) {
		rotate(r*roof_stick_rotation(), [0,0,1]) 
            roof_stick();    
    }    
}

module king() {
	$fn=NUM_SIDES;
    
	base();
    
	wall();
    
	cornise();
    
    battlement();
    
	ring();

    net();    
    
 	roof();

	central_stick();
    
	ball();
}

