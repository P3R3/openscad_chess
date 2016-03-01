NUM_SIDES=8;

BASE_SIZE=0.5;

BASE_HEIGHT=0.25;

WALL_SIZE=0.3;

WALL_HEIGHT=2;

CORNISE_HEIGHT=0.25;

BATTLEMENTS_OUTER_SIZE=BASE_SIZE;

BATTLEMENTS_OUTER_HEIGHT=0.125; 

BATTLEMENTS_INSIDE_SIZE=0.3;

BATTLLEMENTS_RING_SEPARATION=BATTLEMENTS_OUTER_HEIGHT;

SHAFT_OFFSET=0.4;

RING_OUTER_HEIGHT=BATTLEMENTS_OUTER_HEIGHT;

SHAFT_SIZE=0.05;

BIG_ARROW_OFFSET=2.5;

BIG_ARROW_SIZE=0.15;

function wall_levitation() = BASE_HEIGHT;

function cornise_levitation() = wall_levitation()+WALL_HEIGHT;

function battlements_outer_levitation() = cornise_levitation()+CORNISE_HEIGHT;

function battlements_inside_levitation() = battlements_outer_levitation()-0.25;

function ring_outer_levitation() = 
    battlements_outer_levitation()+
    BATTLEMENTS_OUTER_HEIGHT+
    BATTLLEMENTS_RING_SEPARATION;
    
function ring_inside_levitation() = ring_outer_levitation()-0.25;

function shaft_levitation() = battlements_outer_levitation()+BATTLEMENTS_OUTER_HEIGHT;

function arrow_head_levitation() = RING_OUTER_HEIGHT+ring_outer_levitation();

module base() {
    cylinder(r=BASE_SIZE, h=BASE_HEIGHT);
}


module wall() {
    translate([0, 0, wall_levitation()]) 
        cylinder(r=WALL_SIZE, h=WALL_HEIGHT);
}

module cornise() {
    translate([0, 0, cornise_levitation()]) 
        cylinder(r1=WALL_SIZE, r2=BATTLEMENTS_OUTER_SIZE, h=CORNISE_HEIGHT);
}


module battlements_outer() {
    translate([0, 0, battlements_outer_levitation()]) 
        cylinder(r=BATTLEMENTS_OUTER_SIZE, h=BATTLEMENTS_OUTER_HEIGHT);
}



module battlements_inside() {
    translate([0, 0, battlements_inside_levitation()]) 
        cylinder(r=BATTLEMENTS_INSIDE_SIZE, h=4*BATTLEMENTS_OUTER_HEIGHT);
}


module battlements() {
	difference() {
		battlements_outer();
		battlements_inside();
	}
}



module ring_outer() {
    translate([0, 0, ring_outer_levitation()]) 
        cylinder(r=BATTLEMENTS_OUTER_SIZE, h=BATTLEMENTS_OUTER_HEIGHT);
}

 
module ring_inside() {
		translate([0, 0, ring_inside_levitation()]) 
            cylinder(r=BATTLEMENTS_INSIDE_SIZE, h=4*BATTLEMENTS_OUTER_HEIGHT);    
}

module ring() {
    difference() {
        ring_outer();
        ring_inside();
	}
}

module shaft() {
    translate([SHAFT_OFFSET, 0, shaft_levitation()]) 
                cylinder(r=SHAFT_SIZE, h=BATTLLEMENTS_RING_SEPARATION);
}
module arrow_head() {
    translate([SHAFT_OFFSET, 0, arrow_head_levitation()]) 
                cylinder(r1=SHAFT_SIZE, r2=0, h=BATTLLEMENTS_RING_SEPARATION);    
}


module little_arrow() {
    shaft();
    arrow_head();
}

module little_arrows() {
    for(r = [0:7]) {
        rotate(r*360/8, [0,0,1]) 
            little_arrow();
	}
}



module big_arrow() {
    translate([0, 0, BIG_ARROW_OFFSET]) 
        cylinder(r1=BIG_ARROW_SIZE, r2=0, h=2*BASE_SIZE);
}

module queen() {
	$fn = NUM_SIDES;
	
    base();
    
	wall();
    
    cornise();
    
	battlements();
    
    ring();
    
    little_arrows();
    
    big_arrow();
}




 