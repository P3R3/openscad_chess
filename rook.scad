NUM_SIDES=4;
DUNGEONS_SIZE=1;
DUNGEONS_HEIGHT=0.25;
WALL_SIZE=0.35;
WALL_HEIGHT=1.625;
BATLLEMENTS_OUTER_SIZE=0.45;
BATLLEMENTS_OUTER_HEIGHT=0.5;
BATLLEMENTS_INSIDE_SIZE=0.375;
CORNISE_HEIGHT=0.1;
MERLON_SIZE=0.075;
MERLON_HEIGHT=0.2;

function half(num) = num/2;
function twice(num) = num*2;
function wall_levitation() = DUNGEONS_HEIGHT;
function cornise_levitation() = WALL_HEIGHT+wall_levitation();
function batllements_outer_levitation() = CORNISE_HEIGHT+cornise_levitation();
MERLONS_LEVITATION = 2.35;



module rook() {
	$fn=NUM_SIDES;
	dungeons();
    wall();
	cornice();
    battlements();
	merlons();
}

module dungeons()  {
   	cylinder(r=half(DUNGEONS_SIZE), h=DUNGEONS_HEIGHT);
}

module wall() {
	translate([0,0,wall_levitation()]) 
      cylinder(r=WALL_SIZE, h=WALL_HEIGHT);
}


module cornice() {
    translate([0,0,cornise_levitation()]) 
        cylinder(r1=WALL_SIZE, r2=BATLLEMENTS_OUTER_SIZE, h=CORNISE_HEIGHT);
}


module battlements_outer() {
    translate([0,0,batllements_outer_levitation()]) 
        cylinder(r=BATLLEMENTS_OUTER_SIZE, h=BATLLEMENTS_OUTER_HEIGHT);
}
module battlements_inside() {
    translate([0,0,MERLONS_LEVITATION]) 
        cylinder(r=BATLLEMENTS_INSIDE_SIZE, h=twice(BATLLEMENTS_OUTER_HEIGHT));
}


module battlements() {
	difference() {
		battlements_outer();
		battlements_inside();
	}
}

module merlon() {
    translate([0.25,0,MERLONS_LEVITATION]) 
        cylinder(r=MERLON_SIZE, h=MERLON_HEIGHT);
}

module merlons() {
	merlon();
    mirror([1,0,0]) merlon();
    mirror([1,0,0]) merlon();
    mirror([1,1,0]) merlon();
    mirror([1,-1,0]) merlon();
}
