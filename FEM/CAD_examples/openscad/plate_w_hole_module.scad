//facets    
$fn=40;
//cube

module pwh(length, width, thick) {
    difference(){
        cube([length, width, thick]);
        //cylinder for hole
        translate([length/2, width/2, 0]) cylinder(r1=1,r2=1,3);
        }
}

pwh(6,6,1); //plate with hole
rotate(a=90, v=[0,-1,0]) pwh(6,6,1); //plate with hole