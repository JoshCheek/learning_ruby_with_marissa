class C1
  def m
    '1'
  end
end

class C2 < C1
  def m
    super + '2'
  end
end


class C3 < C2
  def m
    super + '3'
  end
end

C1.superclass # => Object
C2.superclass # => C1
C3.superclass # => C2

C1.new.m # => "1"
C2.new.m # => "12"
C3.new.m # => "123"
