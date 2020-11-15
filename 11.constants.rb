class A
  class B
  end

  class C
    class D
      E = 456
    end
  end

  E = 12
end

# Two colons, `::`, are called the "scope resolution operator"
A.constants # => [:E, :B, :C]
A::B        # => A::B
A::C        # => A::C
A::C::D     # => A::C::D
A::C::D::E  # => 456
A::E        # => 12
