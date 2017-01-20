def your_sort(array, &block)
  normalized_block = block || Proc.new {|a, b| a <=> b}
  array.sort {|a, b| normalized_block.call(a, b)}
end
