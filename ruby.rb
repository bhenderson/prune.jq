# implement prune in ruby so I can see how to do it in jq
require 'json'

def debug(*args)
  p [:debug, args]
end

def prune(data, &blk)
  case data
  when Hash
    data.keys.each do |key|
      val = data.delete key
      val = prune(val, &blk)
      if val.is_a?(Hash) or val.is_a?(Array) or blk.call(key, val)
        data[key] = val
      end
    end
    if data.empty? then nil else data end
  when Array
    data.each_with_index do |val, key|
      val = data[key]
      val = prune(val, &blk)
      if val.is_a?(Hash) or val.is_a?(Array) or blk.call(key, val)
        data[key] = val
      else
        data[key] = nil
      end
    end
    data.compact!
    if data.empty? then nil else data end
  else
    data
  end
end

data = JSON.load ARGF.read

# recursively prune any key/value pair where block doesn't return true.
exp = prune(data) {|k, v|
  v =~ /sunt/
}

puts JSON.pretty_generate exp
