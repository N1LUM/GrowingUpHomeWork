class Flatten

  def flatten_functional(array)
    array.reduce([]) do |acc, item|
      acc + (item.is_a?(Array) ? flatten_functional(item) : [item])
    end
  end

  def flatten_imperative(array)
    result = []
    stack = array.reverse

    until stack.empty?
      item = stack.pop
      if item.is_a?(Array)
        stack.concat(item.reverse)
      else
        result << item
      end
    end

    result
  end
end