include <pawn.scad>
include <rook.scad>
include <bishop.scad>
include <knight.scad>
include <queen.scad>
include <king.scad>

module all() {
	for(i = [-5.25:1.5:5.25]) {
		translate([0.75, i, 0]) pawn();
	}

	translate([-0.75, -5.25, 0]) rook();
	translate([-0.75, -3.75, 0]) knight();
	translate([-0.75, -2.25, 0]) bishop();
	translate([-0.75, -0.75, 0]) queen();
	translate([-0.75, 0.75, 0]) king();
	translate([-0.75, 2.25, 0]) bishop();
	translate([-0.75, 3.75, 0]) knight();
	translate([-0.75, 5.25, 0]) rook();
}


LIGHT = [0.8,0.8,0.8];
DARK = [0.6,0.6,0.6];
SQUARE_SIZE = 1.5;
SQUARE_THICKNESS = 0.2;
NUM_SQUARES_BY_SIDE = 8;

function half(num) =  num/2;

module square(color) {
    color(color) 
        cube([SQUARE_SIZE, SQUARE_SIZE, SQUARE_THICKNESS] ,center=true);
}

module square_board(x, y) {
    if((x+y)%2 == 1) square(LIGHT); 
	else square(DARK);
}

function left_corner() = -half(NUM_SQUARES_BY_SIDE)*SQUARE_SIZE;
function next_center(pos) = pos*SQUARE_SIZE;
function left_corner_center() = left_corner()+half(SQUARE_SIZE);
function square_center(pos) = left_corner_center()+next_center(pos);
function square_height() = -half(SQUARE_THICKNESS);

module board() {
	for(x = [0:7]) {
		for(y = [0:7]) {
			translate([square_center(x),square_center(y),square_height()])
				square_board(x,y); 
		}
	}
}

scale([5,5,5]){
	board();
	
	translate([-4.5, 0, 0]) color([0.9,0.9,0.9]) all();
	translate([4.5, 0, 0])  mirror([1,0,0]) color([0.5,0.5,0.5]) all();
}