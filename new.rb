def each arr, &block
  block[arr]
end

w = each [1,2,3,4] do |x|
  p x
end

w.call