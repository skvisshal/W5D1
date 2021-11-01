class MaxIntSet
  attr_reader :store

  def initialize(max)
    @max = max
    # @set = Set.new(@max)
    @store = Array.new(max, false)
  end

  def insert(num)
    raise 'Out of bounds' if is_valid?(num)
    @store[num] = true
  end
  
  def remove(num)
    raise 'Out of bounds' if is_valid?(num)
    @store[num] = false
  end

  def include?(num)
    return @store[num]
  end

  private

  def is_valid?(num)
    num >= @max || num < 0   
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count, :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    if !self.include?(num)
      self[num] << num
      @count += 1
      resize! if @count >= @store.length 
    end
  end

  def remove(num)
    @count -= 1 if self[num].delete(num) != nil
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
      temp_store = Array.new(num_buckets * 2) { Array.new }
      @store.each do |sub_arr|
        sub_arr.each do |ele|
          temp_store[ele % temp_store.length] << ele
        end
      end
      @store = temp_store
  end
end
