module TextHelper

  def conjunction(index, length)
    return ' and ' if index == length - 2
    return ', ' if index < length - 1
    return ''
  end

end
