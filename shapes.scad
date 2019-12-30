include <BOSL/constants.scad>
use <BOSL/math.scad>
use <BOSL/shapes.scad>

// Section: Cylindroids


// Module: dcyl()
//
// Description:
//   Creates a clipped cylinder, suitable for 3D printing.
//   `cyl()` extended by
//
// Usage:
//   dcyl(..., [oh_ang], [lay_flat]);
//
// Arguments:
//   oh_ang = Overhang angle. At what angle will the cylinder be clipped? (Default: 45)
//   lay_flat = If true, lay the cylinder flat for printing. If false, stand the cylinder up as normal.
//
// Example: Agressive overhang angle, laid flat
//   dcyl(l=40, d=8, oh_ang=55, lay_flat=true);
//
//
//
// Usage: Normal Cylinders
//   cyl(l|h, r|d, [circum], [realign], [orient], [align], [center]);
//   cyl(l|h, r1|d1, r2/d2, [circum], [realign], [orient], [align], [center]);
//
// Usage: Chamferred Cylinders
//   cyl(l|h, r|d, chamfer, [chamfang], [from_end], [circum], [realign], [orient], [align], [center]);
//   cyl(l|h, r|d, chamfer1, [chamfang1], [from_end], [circum], [realign], [orient], [align], [center]);
//   cyl(l|h, r|d, chamfer2, [chamfang2], [from_end], [circum], [realign], [orient], [align], [center]);
//   cyl(l|h, r|d, chamfer1, chamfer2, [chamfang1], [chamfang2], [from_end], [circum], [realign], [orient], [align], [center]);
//
// Usage: Rounded/Filleted Cylinders
//   cyl(l|h, r|d, fillet, [circum], [realign], [orient], [align], [center]);
//   cyl(l|h, r|d, fillet1, [circum], [realign], [orient], [align], [center]);
//   cyl(l|h, r|d, fillet2, [circum], [realign], [orient], [align], [center]);
//   cyl(l|h, r|d, fillet1, fillet2, [circum], [realign], [orient], [align], [center]);
//
// Example: By Radius
//   xdistribute(30) {
//       cyl(l=40, r=10);
//       cyl(l=40, r1=10, r2=5);
//   }
//
// Example: By Diameter
//   xdistribute(30) {
//       cyl(l=40, d=25);
//       cyl(l=40, d1=25, d2=10);
//   }
//
// Example: Chamferring
//   xdistribute(60) {
//       // Shown Left to right.
//       cyl(l=40, d=40, chamfer=7);  // Default chamfang=45
//       cyl(l=40, d=40, chamfer=7, chamfang=30, from_end=false);
//       cyl(l=40, d=40, chamfer=7, chamfang=30, from_end=true);
//   }
//
// Example: Rounding/Filleting
//   cyl(l=40, d=40, fillet=10);
//
// Example: Heterogenous Chamfers and Fillets
//   ydistribute(80) {
//       // Shown Front to Back.
//       cyl(l=40, d=40, fillet1=15, orient=ORIENT_X);
//       cyl(l=40, d=40, chamfer2=5, orient=ORIENT_X);
//       cyl(l=40, d=40, chamfer1=12, fillet2=10, orient=ORIENT_X);
//   }
//
// Example: Putting it all together
//   cyl(l=40, d1=25, d2=15, chamfer1=10, chamfang1=30, from_end=true, fillet2=5);
module dcyl(
	l=undef, h=undef,
	r=undef,
  //r1=undef, r2=undef,
	d=undef,
  //d1=undef, d2=undef,
	chamfer=undef, chamfer1=undef, chamfer2=undef,
	chamfang=undef, chamfang1=undef, chamfang2=undef,
	fillet=undef, fillet1=undef, fillet2=undef,
	circum=false, realign=false, from_end=false,
	//orient=ORIENT_Z, align=V_CENTER,
  //center=undef,
  oh_ang=45,lay_flat=false
) {
  r = is_undef(d) ? r : d/2;
	sides = segs(r);
	sc = circum? 1/cos(180/sides) : 1;
  if (lay_flat) {
    _dcyl(h=h,r=r,oa=oh_ang);
  } else {
    rotate([90,0]) translate([0,0,-cos(oh_ang)*r*sc]) _dcyl(h=h,r=r,oa=oh_ang);
  }

  module _dcyl(h,r,oa) {
    difference() {
      translate([0,0,r*sc*cos(90-oa)]) rotate([-90,0]) cyl(h=h,r=r);
      downcube([r*2,h+2,r]);
    }
  }
}
