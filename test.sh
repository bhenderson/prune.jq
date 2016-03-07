
test_prune() {
  local filter="$1" \
        exp="$2" \
        input="$3"

  diff -u <(echo "$exp") <(<<< "$input" jq -c 'include "prune"; prune('"${filter}"')')
}

test_prune '.value == "b"' '["b"]' '["a", "b", "c"]'
test_prune '.value == "c"' '[{"b":"c"}]' '[{"a": "b"}, {"b": "c"}, {"d": "e"}]'
