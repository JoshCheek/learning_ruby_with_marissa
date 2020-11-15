# =====  Chaining method calls  =====
# When we call a method, we call it on whatever the expression evaluates to
# This means that chaining methods leads to methods called on the return value of the previous expression

#*****
# What will this expression evaluate to?
'abc'
  .upcase   # => "ABC"
  .reverse  # => "CBA"
  .downcase # => "cba"
  .chars    # => ["c", "b", "a"]
  .first    # => "c"

#*****
# The dot can go on the preceeding line, or the current line
'abc'.      # => "abc"
  upcase.   # => "ABC"
  reverse.  # => "CBA"
  downcase. # => "cba"
  chars.    # => ["c", "b", "a"]
  first     # => "c"

#*****
# We can get all funky with the dot (best practices, ya know?)
'abc'.              # => "abc"
  upcase  .reverse  # => "CBA"
  .downcase.        # => "cba"
  chars             # => ["c", "b", "a"]
.  first            # => "c"
