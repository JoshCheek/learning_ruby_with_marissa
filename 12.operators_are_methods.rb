class Integer
  def +(other)
    [100, other]
  end
end
1.+(2) # => [100, 2]
1.+ 2  # => [100, 2]
1 + 2  # => [100, 2]

class Integer
  def +(other)
    self
  end
end
1 + 2 # => 1
2 + 1 # => 2
