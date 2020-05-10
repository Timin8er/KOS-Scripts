IF DEFINED staging_config {

  // initialize the stage index if is hasn't yet
  IF NOT (DEFINED staging_config_index) {
    SET staging_config_index TO 0.
  }

  LOCAL delay TO staging_config[staging_config_index].

  // if delay is 0, only stage once.
  if delay = 0 {
    STAGE.

  // if not, stage twice with the given delay.
  } ELSE {
    STAGE.
    WAIT delay.
    STAGE.
  }.

  // increment the stage index if we're not at the end.
  IF staging_config_index < staging_config:LENGTH {
    SET staging_config_index TO staging_config_index + 1.
  }.

} ELSE {
  STAGE.
}
