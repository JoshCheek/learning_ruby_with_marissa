class Dog
  def initialize(name, toy)
    self # => #<Dog:0x00007fc6950e3428>
    @name = name
    @toy  = toy
    self # => #<Dog:0x00007fc6950e3428 @name="Bulleit", @toy="tennis ball">
  end

  def name=(new_name)
    @name = new_name
  end

  def name
    @name
  end
end

bulleit = Dog.new('Bulleit', 'tennis ball')
# => #<Dog:0x00007fc6950e3428 @name="Bulleit", @toy="tennis ball">

bulleit.name # => "Bulleit"
bulleit.name=('Rye')
bulleit.name # => "Rye"


bulleit.toy rescue $! # => #<NoMethodError: undefined method `toy' for #<Dog:0x00007fc6950e3428 @name="Rye", @toy="tennis ball">\nDid you mean?  to_s>
class Dog
  def toy
    @toy
  end
end
bulleit.toy # => "tennis ball"
(bulleit.toy = 'rope') rescue $! # => #<NoMethodError: undefined method `toy=' for #<Dog:0x00007fc6950e3428 @name="Rye", @toy="tennis ball">\nDid you mean?  toy>
bulleit.instance_variable_set :@toy, 'rope'
bulleit.toy # => "rope"




