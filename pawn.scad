
NUM_SIDES=3;
FEET_SIZE=1;
HIP_SIZE=0.4;
HEAD_SIZE=HIP_SIZE;
HAT_SIZE=HEAD_SIZE;
FEET_HEIGHT=0.25;
LEGS_HEIGHT=0.5;
TORSO_HEIGHT=0.5;
HEAD_HEIGHT=0.25;
HAT_HEIGHT=0.5;


function half(num) = num/2;
function twice(num) = num*2;
function legs_levitation() = FEET_HEIGHT;
function legs_position() = [0,0,legs_levitation()];
function torso_levitation() = legs_levitation()+LEGS_HEIGHT;
function torso_position() = [0,0,torso_levitation()];
function head_levitation() = torso_levitation()+TORSO_HEIGHT;
function head_position() = [0,0,head_levitation()];
function hat_levitation() = head_levitation()+HEAD_HEIGHT;
function hat_position() = [0,0,hat_levitation()];

module pawn() {
    $fn=NUM_SIDES;
	feet();
	legs();
    torso();
	head();
	hat();
}


module feet() {
    cylinder(r=half(FEET_SIZE), h=FEET_HEIGHT);
}

module legs() {
    translate(legs_position())  
     cylinder(r1=half(HIP_SIZE), r2=HIP_SIZE, h=LEGS_HEIGHT);
}
module torso() {
    translate(twice(torso_position()))
        mirror([0,0,1])   
            legs();
}
module head() {
    translate(head_position()) 
        cylinder(r1=half(HEAD_SIZE), r2=HEAD_SIZE, h=HEAD_HEIGHT);
}
module hat() {
	translate(hat_position()) 
        cylinder(r1=HAT_SIZE, r2=0, h=HAT_HEIGHT);    
}

