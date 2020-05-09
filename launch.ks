parameter target_ap, pitch_sqrt_mod, pitch_pow_mod, pitch_line_mod.

SET PITCH_MIN TO 5.
SET SPEED_MIN TO 20.

//////////
// Open the throttle, but save the mono
LOCK THROTTLE TO 1.0.
RCS OFF.

// Point straight up
SET HEAD TO HEADING(90,90).
LOCK STEERING TO HEAD.

STAGE.

UNTIL SHIP:APOAPSIS > target_ap {
	// Handle steering

	SET SPEED TO SHIP:VELOCITY:SURFACE:MAG.

	IF SPEED < SPEED_MIN {
		SET HEAD TO HEADING(90,90).
	} ELSE {
    SET AP TO SHIP:APOAPSIS.
		SET PITCH TO ROUND(90 - SQRT(AP*pitch_sqrt_mod*0.01) + ((AP*pitch_pow_mod*0.000001)^2) + (AP*pitch_line_mod*0.00001), 1).
		IF PITCH < PITCH_MIN SET PITCH TO PITCH_MIN.

		SET HEAD TO HEADING(90, PITCH).
	}.

  // staging
  LIST ENGINES IN ENGLIST.
  FOR ENG IN ENGLIST {
  	IF ENG:FLAMEOUT = TRUE {
      STAGE.
      BREAK.
  	}.
  }.

}.

LOCK THROTTLE TO 0.

// We will want RCS here in case something goes wrong (like fast forward)
RCS ON.
SAS ON.
SET SASMODE TO "PROGRADE".

LOCK THROTTLE TO 0.

// Because we can
PANELS ON.
RADIATORS ON.

// This sets the user's throttle setting to zero to prevent the throttle
// from returning to the position it was at before the script was run.
SET SHIP:CONTROL:PILOTMAINTHROTTLE TO 0.
