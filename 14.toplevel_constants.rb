# Constants defined from main are stored in `Object`
class Omghi
end
VERSION = '1.2.3'

Object.constants.grep(/Omghi|VERSION/) # => [:RUBY_VERSION, :RUBY_ENGINE_VERSION, :Omghi, :VERSION]


# `Object` is "cbase", the first place to look for constants
Omghi         # => Omghi
Object::Omghi # => Omghi

VERSION         # => "1.2.3"
Object::VERSION # => "1.2.3"

# One other thing you will see is a scope resolution operator with nothing on the LHS
# this tells Ruby to look from Object instead of the current class / module
class Omghi
  VERSION = '9.9.9'

  VERSION   # => "9.9.9"
  ::VERSION # => "1.2.3"
end
