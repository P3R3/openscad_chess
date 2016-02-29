NUM_SIDES=4;

module rook() {
	$fn=NUM_SIDES;
	dungeons();
    wall();
	cornice();
    battlements();
	merlons();
}

module dungeons()  {
   	cylinder(r=0.5, h=0.25);
}

module wall() {
	translate([0,0,0.25]) cylinder(r=0.35, h=1.625);
}


module cornice() {
    translate([0,0,1.875]) cylinder(r1=0.35, r2=0.45, h=0.1);
}


module battlements() {
	difference() {
		translate([0,0,1.975]) cylinder(r=0.45, h=0.5);
		translate([0,0,2.35]) cylinder(r=0.375, h=1);
	}
}

module merlons() {
	translate([0.25,0,2.35]) cylinder(r=0.075, h=0.2);
	translate([-0.25,0,2.35]) cylinder(r=0.075, h=0.2);
	translate([0,0.25,2.35]) cylinder(r=0.075, h=0.2);
	translate([0,-0.25,2.35]) cylinder(r=0.075, h=0.2);    
}


