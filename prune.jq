def _prune_object(f):
  to_entries |
    map(.value |= f // empty ) |
    map(select(.)) |
    from_entries |
    if (keys | length > 0) then . else empty end
  ;

def _prune_array(f):
  map(. |= f // empty ) |
  map(select(.)) |
  if (length > 0) then . else empty end
  ;

def prune(f):
  if type == "object" then
    _prune_object(prune(f))
  else
    if type == "array" then
      _prune_array(prune(f))
    else
      if f? then . else empty end
    end
  end
  ;
