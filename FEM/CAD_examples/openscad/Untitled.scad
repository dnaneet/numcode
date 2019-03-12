//facet number
$fn=25; //Facets in spherical primitives
        //Think of this as resolution

//cube
cube([5,5,5]);
cube([2,2,2], center=true);

//sphere
%sphere(10); //% sign makes transparent
  
//cylinder
cylinder(r1=5, r2=5, h=10);

//translation
translate([10,0,0]) cube([3,3,3]); //translate is an operation

//rotate
rotate(a=90, v=[1,0,0]) cylinder(r1=5, r2=5, h=20);
//a=angle, v=vector rotate around axis 

//loop
*for(i=[10:10:100]) {
#translate([15,i,0]) cylinder(r1=5, r2=1, h=10);
}
//*disables a code snippet