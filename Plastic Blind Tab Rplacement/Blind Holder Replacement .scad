//set global paramaeters
// Base polygon
base_width = 7;
base_length = 90;
base_depth = 2;

// Inset distance
inset_width = 13;
inset_length = 12;
inset_depth = base_depth;

//tidycuts
tidycut_width = inset_width /3.25;
tidycut_height = inset_length -2;
tidycut_depth = base_depth*4;

//tidycut variable
cut_adjuster = 1; // Move the cut left and right
cut_inset_1 = 5; // Move the top hole down
cut_inset_2 = 11; // Move the Bottom hole up

//define modules
//base cube module
module base_square (){
      cube(
        [base_width,
         base_length,
         base_depth]
        );
    }

//Inset square module    
module inset_square(){
        cube(
            [inset_width,
             inset_length,
             inset_depth]
            );
}

//Subtractive Square module
module subtractive_square(){
        cube(
            [
            tidycut_width,
            tidycut_height,
            tidycut_depth
            ]
            );
    }

//render objects
//render the base cube
//base_square();

difference(){
// Render the inset square
translate([base_width- inset_width/2, base_length / 2 - inset_length/2, 0]) inset_square();

//subtract the inset square and base cube with 2 subtracctive squares
    //cut 1
      translate([base_width- inset_width/2 + (inset_length - cut_inset_1), 
    (base_length / 2 - inset_length/2)+cut_adjuster, 
    -1])
          subtractive_square();
    //cut 2
       translate([base_width- inset_width/2 + (inset_length-cut_inset_2), 
    (base_length / 2 - inset_length/2)+cut_adjuster, 
    -1])
    subtractive_square();
};


difference(){
    base_square();
    
     //cut 2
       translate([base_width- inset_width/2 + (inset_length-cut_inset_2), 
    (base_length / 2 - inset_length/2)+cut_adjuster, 
    -1])
    subtractive_square();
    }