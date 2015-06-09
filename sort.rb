def your_sort(array, &block)
  normalized_block = block || Proc.new{|a, b| a <=> b}
  sort(array, normalized_block)   
end

def sort(array, block)
  array.inject([]) { |sorted, element| insert_in_right_place(sorted, element, block) }
end

def insert_in_right_place(sorted_list, element, block)
  sorted_list.each_with_index do |list_el, i|
    return sorted_list.insert(i, element) if block.call(element, list_el) < 1
  end
  sorted_list << element
end