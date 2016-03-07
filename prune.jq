def prune(f):
  def _prune_object(f):
    to_entries |
      map(.value |= prune(f) | select(
        (.value | type == "object" or type == "array") or f
      )) |
      from_entries |
      if (keys | length > 0) then . else empty end
    ;

  def _prune_array(f):
    to_entries |
      map(.value |= prune(f) | select(
        (.value | type == "object" or type == "array") or f
      ) | .value) |
      if (length > 0) then . else empty end
    ;

  if type == "object" then
    _prune_object(f)
  elif type == "array" then
    _prune_array(f)
  else
    .
  end
  ;
