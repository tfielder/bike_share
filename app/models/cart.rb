class Cart
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || Hash.new(0)
  end

  def total_count
    @contents.values.sum
  end

  def add_accessory(id)
    binding.pry
    @contents[id] = @contents[id] + 1
  end

  def accessories
    @contents.map do |id, count|
      [Accessory.find(id), count]
    end
  end
end
