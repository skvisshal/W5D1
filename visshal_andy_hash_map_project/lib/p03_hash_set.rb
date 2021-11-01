class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
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
    @store[num.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
      temp_store = Array.new(num_buckets * 2) { Array.new }
      @store.each do |sub_arr|
        sub_arr.each do |ele|
          temp_store[ele.hash % temp_store.length] << ele
        end
      end
      @store = temp_store
  end
end
