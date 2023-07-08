 // GLOBAL VARIABLES --------

//Base polygon globals
base_depth = 5;
base_length = 140;
base_width = 95;

//create wall
wall_inset = base_cutout_width;
wall_width = 55 ;
wall_length = base_length;
wall_depth = 62;

//Base cutout globals
base_cutout_depth = base_depth;
base_cutout_length = 50;
base_cutout_width = (base_width - wall_width) / 2;

//wall cutout globals
theta =45;
cutout_max = 40;

//bolt dimensions
m10_length = 150;
m10_radius = 5;

// Inset Wall dimensions
inset_wall_width = wall_width - 10 ;
inset_wall_length = base_length;
inset_wall_depth = 80;

// Cable management hole dims
cable_hole_length = 15;
cable_hole_height = 10;
cable_hole_depth = 10;

// OBJECT GENERATION, ROTATION AND DIFFERENCES-------
//create base object and take difference
module base_cutout () {
    linear_extrude(height = base_cutout_depth) 
        polygon(
            [[0, 0], 
            [0, base_cutout_length], 
            [base_cutout_width, base_cutout_length]]); 
}


// define the base square
module base_square() {
    cube([base_width,
        base_length,
        base_depth]
        );
}


 //makes 2 triangles and minuses them from the base
difference() {
    base_square();
    translate([0,base_length- base_cutout_length, 0])
        base_cutout();
    translate([base_width,base_length-base_cutout_length, 0]) {
        scale([-1, 1, 1]) base_cutout();
    }
};

// Wall Module ---
// slaps another cube ontop of the base
module wall_cube () {
    cube([wall_width,
        wall_length,
        wall_depth]
    );
}

//Moves the wall cube to the centre of the object
module moved_wall_cube() {
    translate([(base_width/2) - (wall_width/2),0,base_depth])
        wall_cube();
}


// Create wall angle cutout module
module wall_angle_cutout() {
    linear_extrude(height =  300) 
        polygon(
            [[0, 0], 
            [0, cutout_max * cos(theta + 90)], 
            [cutout_max, 0]]); 
}


//move the wall angle cutout
module wall_cube_angle_cutout() {
    translate([(base_width/2) - (wall_width/2),
                base_length,
                (wall_depth+base_depth)]) 
    {
        rotate([0,90,0]) wall_angle_cutout();
    }
}

// Build a second cutout for the m10 65mm bolt
module m10_65mm_cyl () {
    cylinder(h = m10_length,r =m10_radius, centre = true);
}


module m10_65mm_cutout() {
    translate([-30,125,23])
    {rotate([0,90,0]) m10_65mm_cyl();}    
    }

// Build a third cutout for the m10 95mm bolt
module m10_95mm_cutout() {
    translate([base_width/2,
    140,wall_depth -7])
    {rotate([90,0,0]) m10_65mm_cyl();}    
    }
    
// finally extrude the remainder of the innner wall
module wall_inset_cube () {
    cube(
        [inset_wall_width,
        inset_wall_length,
        inset_wall_depth]
    );
 }


module wall_inset_cube_position (){
    translate([base_width/2 - wall_width/2 + 5,
                base_depth,
                base_depth])
        wall_inset_cube();
    }


// this point gets you to the orignal 
// I want to make it nicer to cable manage
module cable_wall_hole () {
    cube(
        [cable_hole_height,
         cable_hole_length,
         cable_hole_depth]
    );
    }

module cable_wall_hole_position () {
    translate([20,10,base_depth])
        cable_wall_hole();
    }

// Difference the cube with bolt holes
difference() {
    moved_wall_cube();
    wall_cube_angle_cutout();
    m10_65mm_cutout();
    m10_95mm_cutout();
    wall_inset_cube_position();
    cable_wall_hole_position();
}




