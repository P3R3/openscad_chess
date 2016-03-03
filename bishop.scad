NUM_SIDES=6;

BASE_SIZE=0.5;

BASE_HEIGHT=0.25;

CORNISE_SIZE=0.2;

WALL_SIZE=0.3;

WALL_HEIGHT=1.5;

CORNISE_HEIGHT=0.25;

TOP_WALL_SIZE=0.4;

TOP_WALL_HEIGHT=0.25;

HOOD_SIZE=0.1;

HOOD_HEIGHT=0.4;

GAP_SIZE=0.5;

GAP_HEIGHT=0.1;

GAP_HEIGHT=0.1;

GAP_OFFSET=0.35;

BOTTOM_SPIKE_HEIGHT=0.1;

BOTTOM_SPIKE_SIZE=0.1;

TOP_SPIKE_SIZE=0.2;

TOP_SPIKE_HEIGHT=0.2;


function wall_levitation() = BASE_HEIGHT;

function cornise_levitation() =  wall_levitation() + WALL_HEIGHT;

function top_wall_levitation() = cornise_levitation()+CORNISE_HEIGHT;

function hood_levitation() =top_wall_levitation()+TOP_WALL_HEIGHT;

function gap_levitation() = hood_levitation()+0.25;

function bottom_spike_levitation() = hood_levitation()+HOOD_HEIGHT;

function top_spike_levitation() = bottom_spike_levitation()+BOTTOM_SPIKE_HEIGHT;


module base() {
    cylinder(r=BASE_SIZE, h=BASE_HEIGHT);    
}

module wall() {
    translate([0,0,wall_levitation()]) 
        cylinder(r1=WALL_SIZE, r2=CORNISE_SIZE, h=WALL_HEIGHT);    
    
}

module cornise() {
    translate([0,0,cornise_levitation()]) 
        cylinder(r1=CORNISE_SIZE, r2=TOP_WALL_SIZE, h=CORNISE_HEIGHT);    
    
}

module top_wall() {
    translate([0,0,top_wall_levitation()]) 
        cylinder(r=TOP_WALL_SIZE, h=TOP_WALL_HEIGHT);    
}

module hood() {
    translate([0,0,hood_levitation()]) 
        cylinder(r1=TOP_WALL_SIZE, r2=HOOD_SIZE, h=HOOD_HEIGHT);    
}

module gap() {
    translate([GAP_OFFSET,0,gap_levitation()]) 
        rotate(-45, [0,1,0]) 
            cylinder(r=GAP_SIZE, h = GAP_HEIGHT);    
}

module helmet() {
	difference() {
		hood();
		gap();
	}
}

module bottom_spike() {
    translate([0,0,bottom_spike_levitation()]) 
        cylinder(r1=BOTTOM_SPIKE_SIZE, r2=TOP_SPIKE_SIZE, h=BOTTOM_SPIKE_HEIGHT);    
}

module top_spike() {
    translate([0,0,top_spike_levitation()]) 
        cylinder(r1=TOP_SPIKE_SIZE, r2=0, h=TOP_SPIKE_HEIGHT);    
}

module spike() {
   	bottom_spike();
	top_spike();
}    


module bishop() {
    
	$fn=NUM_SIDES;
    
	base();
    
	wall();
    
	cornise();
    
	top_wall();
    
    helmet();
  
    spike();
}


 



