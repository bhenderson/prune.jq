def prune(f):
  def _prune_object(f):
    with_entries(select(f or (.value |= prune(f))))
    ;

  def _prune_array(f):
    to_entries | map(select(f or (.value | prune(f))) | .value)
    ;

  if type == "object" then
    _prune_object(f)
  else
    if type == "array" then
      _prune_array(f)
    else
      if f? then . else empty end
    end
  end
  ;
