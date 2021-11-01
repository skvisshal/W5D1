require_relative 'p04_linked_list'

class HashMap
  extend Enumerable

  attr_accessor :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    if include?(key) 
      bucket(key).update(key,val) 
    else
      bucket(key).append(key,val)
      @count += 1
      resize! if @count >= @store.length 
    end
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    @count -= 1 if bucket(key).remove(key) != nil 
  end

  def each(&prc)
    @store.each do |list|
      list.each do |node|
        prc.call(node.key,node.val)
      end 
    end
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    temp_store = Array.new(num_buckets * 2) { LinkedList.new }
    @store.each do |sub_list|
      sub_list.each do |ele|
        if temp_store[ele.key.hash % temp_store.length].include?(ele.key) 
          temp_store[ele.key.hash % temp_store.length].update(ele.key,ele.val) 
        else
          temp_store[ele.key.hash % temp_store.length].append(ele.key,ele.val)
        end
      end
    end
    @store = temp_store
  end

  def bucket(key)
    @store[key.hash % num_buckets]
    # optional but useful; return the bucket corresponding to `key`
  end
end
