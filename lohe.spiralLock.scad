/* ====================================================================

  This is a 3D model of a mechanical puzzle. It is released under
  the following license:

  Creative Commons Attribution-NonCommercial-NoDerivs 3.0 Unported
  https://creativecommons.org/licenses/by-nc-nd/3.0/

  This means the model is licensed for personal, noncommercial use
  only. Anyone may print a copy for their own use, but selling or
  otherwise monetizing the model or print (or any derivatives) is
  prohibited. For details, refer to the summary at the above URL.

  Puzzle design (c) Christoph Lohe
  3D model (c) Dave Crabbe
  

==================================================================== */

include <puzzlecad.scad>

require_puzzlecad_version("2.1");

$burr_scale = 10;
$burr_inset = 0.1;      // Use 0.09 for a tighter fit
$burr_bevel = 0.5;

// uncomment an object to render
*frame();
*shackle();
*curved_shackle();
*pieces1();
pieces2();


module frame() {

    burr_plate([
        [ "xxxxxx|xxxxxx|xxxxxx|xxxxxx",
          "x....x|xx...x|x....x|x....x",
          "x....x|xx...x|x....x{connect=fx-z+,clabel=B}|x....x",
          "x....x|x....x|x....x|x....x",
          "x{connect=mz+y+,clabel=A}....x{connect=mz+y+,clabel=A}|x....x|x....x|x{connect=mz+y+,clabel=A}....x{connect=mz+y+,clabel=A}" ]
        ], $burr_bevel_adjustments = "z+=0.01,y-=1,y+=1,z-=1");
        
    translate([6 * $burr_scale + $plate_sep, 0, 0])
    burr_plate([
        [ "x{connect=mz+y+,clabel=B}" ]
    ]);

    translate([0, 4 * $burr_scale + $plate_sep, 0])
    burr_plate([
        [ "x{connect=fz-y+,clabel=A}xxxxx{connect=fz-y+,clabel=A}|x....x|x....x|x{connect=fz-y+,clabel=A}xxxxx{connect=fz-y+,clabel=A}" ]
    ], $burr_bevel = 1);

}

module shackle() {
    
    burr_plate([
        [ "xx..|x{label_text=Spiral Lock,label_orient=z+y+,label_voffset=-0.05}...|x...|x.x.|x.xx|x..x|x..x|xxxx",
          "....|....|....|x.x.|x.x{label_text=C.Lohe,label_orient=z+x+,label_hoffset=0.5}x|x..x|x..x|xxxx" ]
    ]);
    
}

module curved_shackle() {
    
    burr_plate([
        [ "xx..|x{label_text=Spiral Lock,label_orient=z+y+,label_voffset=-0.05}...|x...|x.x.|x.xx|x..x|....|....",
          "....|....|....|x.x.|x.x{label_text=C.Lohe,label_orient=z+x+,label_hoffset=0.5}x|x..x|....|...." ]
    ]);

    translate([$burr_scale * 2 - $burr_inset, $burr_scale * 6 - $burr_inset, 0])
    shackle_arc();
    
    translate([$burr_scale * 2 - $burr_inset, $burr_scale * 6 - $burr_inset, 0])
    mirror([1, 0, 0])
    shackle_arc();
    
}

module shackle_arc() {
    
    arc = concat(
        [ for (theta = [90:3:180]) [ ($burr_scale + $burr_inset) * cos(theta), ($burr_scale + $burr_inset) * sin(theta) ] ],
        [ [ -($burr_scale + $burr_inset), -2 * $burr_bevel ], [ -(2 * $burr_scale - $burr_inset), -2 * $burr_bevel ] ],
        [ for (theta = [180:-3:90]) [ (2 * $burr_scale - $burr_inset) * cos(theta), (2 * $burr_scale - $burr_inset) * sin(theta) ] ],
        [ [ 2 * $burr_bevel, 2 * $burr_scale - $burr_inset], [ 2 * $burr_bevel, $burr_scale + $burr_inset ] ]
    );
    
    beveled_prism(arc, height = $burr_scale * 2 - $burr_inset * 2);
    
}

module pieces1() {
    // print in one color (to give spiral effect)
    
    burr_plate([
        [ "xxxx|x..x", "....|x..x","....|x..x"],
        [ "xxxx|x..x|x..x", "....|....|x..x" ]
    ], $burr_outer_x_bevel = 1);
    
}

module pieces2() {
    // print in another color (to give spiral effect)
    
    burr_plate([
        [ "xxxx|x..x", "....|x..x","....|x..x"],
        [ "x.xx|xxxx|x..x", "....|.x..|x..x" ]
    ], $burr_outer_x_bevel = 1);
    
}
