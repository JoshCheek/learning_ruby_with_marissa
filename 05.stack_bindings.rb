class Binding
  def inspect
    locals = local_variables.map { |v| "#{v}: #{local_variable_get(v).inspect}" }
    "Binding[#{receiver.inspect}]{#{locals.join(', ')}}"
  end
end

def a(letter)
  x = 11
  { a: binding }.merge(b("r"))
end

def b(letter)
  x = 22
  { b: binding }.merge(c("s"))
end

def c(letter)
  x = 33
  { c: binding }
end

a("q")
# => {:a=>Binding[main]{letter: "q", x: 11},
#     :b=>Binding[main]{letter: "r", x: 22},
#     :c=>Binding[main]{letter: "s", x: 33}}
