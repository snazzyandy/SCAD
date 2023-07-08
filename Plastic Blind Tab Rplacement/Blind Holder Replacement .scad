//set global paramaeters
// Base polygon
base_width = 7;
base_length = 90;
base_depth = 0.9;

// Inset distance
inset_width = 13;
inset_length = 12;
inset_depth = base_depth;

//tidycuts
tidycut_width = 0.2;
tidycut_height = 0.2;
tidycut_depth = base_depth;

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
base_square();

// Render the inset square
translate([base_width- inset_width/2, base_length / 2 - inset_length/2, 10]) inset_square();

//subtract the inset square and base cube with 2 subtracctive squares
    //cut 1
      translate([0,10,10])
          subtractive_square();
    //cut 2
       translate([0,10,20])
           subtractive_square();