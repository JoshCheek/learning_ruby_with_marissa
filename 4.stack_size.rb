{a: "A"}.merge({b: "B"}) # => {:a=>"A", :b=>"B"}

def a
  caller_locations
  # => ["program.rb:33:in `<main>'"]
  { a: caller_locations.size }.merge(b)
end

def b
  caller_locations
  # => ["program.rb:18:in `a'", "program.rb:33:in `<main>'"]
  { b: caller_locations.size }.merge(c)
end

def c
  caller_locations
  # => ["program.rb:24:in `b'",
  #     "program.rb:18:in `a'",
  #     "program.rb:33:in `<main>'"]
  { c: caller_locations.size }
end

a # => {:a=>1, :b=>2, :c=>3}
