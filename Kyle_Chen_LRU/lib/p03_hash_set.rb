require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    unless self.include?(key)
      resize! if @count + 1 > num_buckets
      @count += 1
      self[key].push(key)
    end
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    @count -= 1
    self[key].delete(key)
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
    dup_store = @store
    @store = Array.new(num_buckets * 2) { Array.new }
    @count = 0
    dup_store.each do |bucket|
      bucket.each do |el|
        insert(el)
      end
    end
  end
end
