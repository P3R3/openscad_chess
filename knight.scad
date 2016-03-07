NUM_SIDES=5;

BASE_SIZE=0.5;

BASE_HEIGHT=0.25;

BOTTOM_SIDE_SIZE=0.2;

MIDDLE_SIDE_SIZE=0.4;

MIDDLE_SIDE_INCLINATION=-0.5;

MIDDLE_SIDE_HEIGHT=1.5;

TOP_SIDE_SIZE=0.5;

TOP_SIDE_HEIGHT=2;

NOSE_MIDDLE_SIDE_XSIZE=0.3;

NOSE_MIDDLE_SIDE_YSIZE=0.2;

NOSE_MIDDLE_SIDE_INCLINATION=0.5;

NOSE_MIDDLE_SIDE_HEIGHT=1.25;

NOSE_BOTTOM_SIDE_XSIZE=0.2;

NOSE_BOTTOM_SIDE_YSIZE=0.05;

NOSE_BOTTOM_SIDE_INCLINATION=-0.25;

NOSE_BOTTOM_SIDE_HEIGHT=0.75;

HEAD_HEIGHT=0.2;

BASE_ARRAY_CORRECTION=1;

CIRCLE_DEGREES=360;

function next_x(x, iteration) = x*cos((CIRCLE_DEGREES/NUM_SIDES)*iteration);

function next_y(y, iteration) = y*sin((CIRCLE_DEGREES/NUM_SIDES)*iteration);

function next_asymmetric_point(x, y, offset, height, iteration) = 
[
offset + next_x(x, iteration), 
next_y(y, iteration),  
height
];

function next_point(x, offset, height, iteration) = 
next_asymmetric_point(x, x, offset, height, iteration);

function bottom_side_points()= [
      next_point(BOTTOM_SIDE_SIZE, 0, 0, NUM_SIDES),
      next_point(BOTTOM_SIDE_SIZE, 0, 0, NUM_SIDES-1),
      next_point(BOTTOM_SIDE_SIZE, 0, 0, NUM_SIDES-2),
      next_point(BOTTOM_SIDE_SIZE, 0, 0, NUM_SIDES-3),
      next_point(BOTTOM_SIDE_SIZE, 0, 0, NUM_SIDES-4),    
    ];

function middle_side_points()=[
      next_point(MIDDLE_SIDE_SIZE, MIDDLE_SIDE_INCLINATION, MIDDLE_SIDE_HEIGHT, NUM_SIDES),
      next_point(MIDDLE_SIDE_SIZE, MIDDLE_SIDE_INCLINATION, MIDDLE_SIDE_HEIGHT, NUM_SIDES-1),
      next_point(MIDDLE_SIDE_SIZE, MIDDLE_SIDE_INCLINATION, MIDDLE_SIDE_HEIGHT, NUM_SIDES-2),
      next_point(MIDDLE_SIDE_SIZE, MIDDLE_SIDE_INCLINATION, MIDDLE_SIDE_HEIGHT, NUM_SIDES-3),
      next_point(MIDDLE_SIDE_SIZE, MIDDLE_SIDE_INCLINATION, MIDDLE_SIDE_HEIGHT, NUM_SIDES-4),    
    ];  

function top_side_points()=[
      next_point(TOP_SIDE_SIZE, 0, TOP_SIDE_HEIGHT, NUM_SIDES),
      next_point(TOP_SIDE_SIZE, 0, TOP_SIDE_HEIGHT, NUM_SIDES-1),
      next_point(TOP_SIDE_SIZE, 0, TOP_SIDE_HEIGHT, NUM_SIDES-2),
      next_point(TOP_SIDE_SIZE, 0, TOP_SIDE_HEIGHT, NUM_SIDES-3),
      next_point(TOP_SIDE_SIZE, 0, TOP_SIDE_HEIGHT, NUM_SIDES-4),      
    ];  

function nose_middle_side_points()  =[
      next_asymmetric_point(NOSE_MIDDLE_SIDE_XSIZE,NOSE_MIDDLE_SIDE_YSIZE, NOSE_MIDDLE_SIDE_INCLINATION, NOSE_MIDDLE_SIDE_HEIGHT, NUM_SIDES),
      next_asymmetric_point(NOSE_MIDDLE_SIDE_XSIZE,NOSE_MIDDLE_SIDE_YSIZE, NOSE_MIDDLE_SIDE_INCLINATION, NOSE_MIDDLE_SIDE_HEIGHT, NUM_SIDES-1),
      next_asymmetric_point(NOSE_MIDDLE_SIDE_XSIZE,NOSE_MIDDLE_SIDE_YSIZE, NOSE_MIDDLE_SIDE_INCLINATION, NOSE_MIDDLE_SIDE_HEIGHT, NUM_SIDES-2),
      next_asymmetric_point(NOSE_MIDDLE_SIDE_XSIZE,NOSE_MIDDLE_SIDE_YSIZE, NOSE_MIDDLE_SIDE_INCLINATION, NOSE_MIDDLE_SIDE_HEIGHT, NUM_SIDES-3),
      next_asymmetric_point(NOSE_MIDDLE_SIDE_XSIZE,NOSE_MIDDLE_SIDE_YSIZE, NOSE_MIDDLE_SIDE_INCLINATION, NOSE_MIDDLE_SIDE_HEIGHT, NUM_SIDES-4),    
    ];

function nose_bottom_side_points() =[
      next_asymmetric_point(NOSE_BOTTOM_SIDE_XSIZE, NOSE_BOTTOM_SIDE_YSIZE, NOSE_BOTTOM_SIDE_INCLINATION, NOSE_BOTTOM_SIDE_HEIGHT, NUM_SIDES),
      next_asymmetric_point(NOSE_BOTTOM_SIDE_XSIZE, NOSE_BOTTOM_SIDE_YSIZE,NOSE_BOTTOM_SIDE_INCLINATION, NOSE_BOTTOM_SIDE_HEIGHT, NUM_SIDES-1),
      next_asymmetric_point(NOSE_BOTTOM_SIDE_XSIZE, NOSE_BOTTOM_SIDE_YSIZE,NOSE_BOTTOM_SIDE_INCLINATION, NOSE_BOTTOM_SIDE_HEIGHT, NUM_SIDES-2),
      next_asymmetric_point(NOSE_BOTTOM_SIDE_XSIZE, NOSE_BOTTOM_SIDE_YSIZE,NOSE_BOTTOM_SIDE_INCLINATION, NOSE_BOTTOM_SIDE_HEIGHT, NUM_SIDES-3),
      next_asymmetric_point(NOSE_BOTTOM_SIDE_XSIZE, NOSE_BOTTOM_SIDE_YSIZE,NOSE_BOTTOM_SIDE_INCLINATION, NOSE_BOTTOM_SIDE_HEIGHT, NUM_SIDES-4),    
    ]; 

module base() {
	cylinder(r=BASE_SIZE, h=BASE_HEIGHT);    
}

module walls(faces_points) {
    
        wall_sides=[
		[0,1,2,3,4],
		[10,14,13,12,11],
		[0,5,6,1],
		[1,6,7,2],
		[2,7,8,3],
		[3,8,9,4],
		[4,9,5,0],
		[5,10,11,6],
		[6,11,12,7],
		[7,12,13,8],
		[8,13,14,9],
		[9,14,10,5]];
	
        polyhedron(points=faces_points, faces=wall_sides);
}

module body() {
    body_sides_points=concat(bottom_side_points(), middle_side_points(), top_side_points());
    
    translate([0,0,BASE_HEIGHT]) 
        walls(body_sides_points);    
}

module nose() {
    nose_sides_points=concat(top_side_points() , nose_middle_side_points(), nose_bottom_side_points()  );
    
    translate([0,0,BASE_HEIGHT])
        walls(nose_sides_points);    
}

module head() {
	translate([0,0,TOP_SIDE_HEIGHT+BASE_HEIGHT])
        cylinder(r1=TOP_SIDE_SIZE,r2=0, h=HEAD_HEIGHT);      
}

module knight() {
	$fn=NUM_SIDES;
    
	base();

    body();
    
    nose();
 
    head();
}


 



