include <Round-Anything/polyround.scad>;
include <./smoothrod_groved.scad>;
include <./frame.scad>;

width         = 15;
angle         = 75;
thickness     = 11;
extra_top     = 2;
extra_bottom  = 2;
lip_top       = 2;
lip_bottom    = 0.6;
magic_number  = 12;
error         = 0.2;
radius_lips   = 4;
radius_top    = 12;
radius_bottom = 15;
radius_right  = 0.4;
radius_left   = 4;

module holder (rr=radius_right,rl=radius_left,error = 0) {
  // Branding
  translate([-thickness*1.5-1, frame.z/2, rl < 1 ? -width/2-1 : width/2])
    rotate([0,0,90])
    linear_extrude(1)
    text("8", size=13, direction="ltr", halign="center", valign="center");
  translate([-thickness*1.5-1, frame.z/2, rl < 1 ? -width/2-1 : width/2])
    linear_extrude(1)
    text("/", size=15, direction="ltr", halign="center", valign="center");
  // The Holder
  let (frame = frame + [0,error,error])
    difference() {
    translate([-frame.y/2,-frame.z/2,-width/2]) {
      polyRoundExtrude(
        holder_silloute(lbot      = lip_bottom,
                        ltop      = lip_top,
                        thickness = thickness,
                        angle     = angle,
                        frame     = frame,
                        r         = radius_lips,
                        rtop      = radius_top,
                        rbot      = radius_bottom,
                        etop      = extra_top,
                        ebot      = extra_bottom,
                        error     = error),
        width,
        rl,
        rr);
    }
    rotate([0,90,180-angle])
      translate([0,magic_number,0])
      smoothrod_groved(dt=error);
  }
}

function holder_silloute (thickness = 10, etop, ebot, ltop, lbot, r, rtop, rbot, angle, frame, error = 0) =
  let (delta  = ((thickness * 2 + frame.z) / tan(angle)))
  [[0                , 0                     , 0],
   [0                , frame.z               , 0],
   [frame.y          , frame.z               , 0],
   [frame.y          , frame.z - ltop        , 0],
   [frame.y+thickness, frame.z - ltop        , r],
   [frame.y+thickness, frame.z+thickness+etop, r],
   [-thickness-delta , frame.z+thickness+etop, rtop],
   [-thickness       , -thickness - ebot     , rbot],
   [frame.y+thickness, -thickness - ebot     , r],
   [frame.y+thickness, lbot                  , r],
   [frame.y          , lbot                  , 0],
   [frame.y          , 0                     , 0]];
