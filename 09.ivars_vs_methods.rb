class Fruit
  attr_accessor :apple

  def initialize(banana)
    @apple = banana
    self.apple = "#{banana} boat"
  end

  def pear
    @apple
  end
end

fruit = Fruit.new('orange')
fruit.pear   # => "orange boat"
fruit.apple  # => "orange boat"

fruit.instance_variable_set '@apple', 'pineapple'
fruit.pear  # => "pineapple"
fruit.apple # => "pineapple"

fruit.apple = 'mango'
fruit.pear  # => "mango"
fruit.apple # => "mango"
