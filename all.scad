include <pawn.scad>
include <rook.scad>
include <bishop.scad>
include <knight.scad>
include <queen.scad>
include <king.scad>

PIECE_LEVITATION = 0;
function piece_position(x,y) = 
[
 square_center(x),
 square_center(y),
 PIECE_LEVITATION
];

module initial_position() {
    for(y = [0:7]) {
        translate(piece_position(1,y)) pawn();
    }    

	translate(piece_position(0,0)) rook();
	translate(piece_position(0,1)) knight();
	translate(piece_position(0,2)) bishop();
	translate(piece_position(0,3)) queen();
	translate(piece_position(0,4)) king();
	translate(piece_position(0,5)) bishop();
	translate(piece_position(0,6)) knight();
	translate(piece_position(0,7)) rook();
}



WHITE = [0.9,0.9,0.9];
BLACK = [0.5,0.5,0.5];
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
function square_position(x,y) = 
[
 square_center(x),
 square_center(y),
 square_height()
];


module board() {
	for(x = [0:7]) {
		for(y = [0:7]) {
			translate(square_position(x,y))
				square_board(x,y); 
		}
	}
}

module positioning_white_pieces() {
    color(WHITE) initial_position();
}
module positioning_black_pieces() {
    mirror([1,0,0]) color(BLACK) initial_position();    
}


scale([5,5,5]){
	board();
	
	positioning_white_pieces();
	positioning_black_pieces();    
    
}