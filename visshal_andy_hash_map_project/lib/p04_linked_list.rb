class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  extend Enumerable
  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    self.each do |node|
      return node.val if node.key == key
    end
    nil
  end

  def include?(key)
    !get(key).nil?
  end

  def append(key, val)
    curr_last_node = @tail.prev
    node_to_insert = Node.new(key,val)
    curr_last_node.next = node_to_insert
    node_to_insert.prev = curr_last_node
    node_to_insert.next = @tail
    @tail.prev = node_to_insert
  end

  def update(key, val)
    self.each do |node|
      node.val = val if node.key == key
    end
  end

  def remove(key)
    return nil if !include?(key)
    node_tobe_removed = nil
    self.each do |node|
      node_tobe_removed = node if node.key == key
    end
    node_tobe_removed.prev.next = node_tobe_removed.next
    node_tobe_removed.next.prev = node_tobe_removed.prev
    node_tobe_removed
  end

  def each(&prc)
    i_node = @head.next
    until i_node == @tail
      prc.call(i_node)
      i_node = i_node.next
    end
  end

  def each_with_index(&prc)
    i_node = @head.next
    index = 0
    until i_node == @tail
      prc.call(i_node,index)
      i_node = i_node.next
      index += 1
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
