class Integer
  # Integer#hash already implemented for you
end

class Array

  def hash
    sum = 0
    self.each_with_index do |ele,i|
      sum += ele^i
    end
    sum
  end

end

class String

  def hash
    sum= 0
    self.each_char.with_index do |char,i|
      sum += char.ord^i
    end
    sum
  end

end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method

  def hash
    sum = 0
    self.each do |key,value|
      sum += (key.object_id)^value.hash
    end
    sum
  end
end
