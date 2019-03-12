//facets
$fn=25;
//cube

difference(){cube([5,5,1]);
//cylinder for hole
translate([2.5, 2.5, 0]) cylinder(r1=1,r2=1,3);}

// Use exclamation (!) to only show the thing with the !.
//Use % to make translucent
//Use # to make red