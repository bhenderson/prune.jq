require 'json'

data = JSON.parse ARGF.read

def prune(data, &blk)
  case data
  when Hash
    data.each do |k, v|
      nv = prune(v, &blk)
      data.delete(k) unless blk.call(k, nv || v)
    end
    if data.empty? then nil else data end
  when Array
    data.each_with_index do |v, k|
      nv = prune(v, &blk)
      data.delete(k) unless blk.call(k, nv || v)
      data[k] = nv
    end.compact!
    if data.empty? then nil else data end
  else
    nil
  end
end

res = prune(data) {|k, v|
  p [k, v]
  v == "t_12342"
}

p :hi, res
