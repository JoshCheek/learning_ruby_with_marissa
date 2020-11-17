# Singleton Class
# The goal: add a method to an individual object
# Each object can / does(?) have its own single class
#
# When we put a method on an object,
# it will create a class if necessary (the singleton class)
# and set that class's superclass to be the original class
#   (so all existing functionality is preserved through inheritance)
# and put that object's methods in its singleton class
#   (so then we can call them on that object specifically)

self                       # => main
  .singleton_class         # => #<Class:#<Object:0x00007fabdd0b5d70>>
  .instance_methods(false) # => [:inspect, :to_s]

self                # => main
  .singleton_class  # => #<Class:#<Object:0x00007fabdd0b5d70>>
  .superclass       # => Object
  .superclass       # => BasicObject
  .superclass       # => nil

# we can see this allows us to override the method to customize main's inspection
self.method(:inspect).owner              # => #<Class:#<Object:0x00007fabdd0b5d70>>
self.method(:inspect).super_method.owner # => Kernel

# we can make our own main object if we like:
main_obj = Object.new
main_obj # => #<Object:0x00007fabdc8cad90>
def main_obj.inspect
  "main"
end
main_obj # => main
main_obj.singleton_class.instance_methods(false) # => [:inspect]
main_obj.singleton_class.superclass              # => Object


# A common example is to add methods to individual classes
# Normally we would expect those methods to be on the class
class Class
  def omghi
    'waaaat'
  end
end

File.omghi     # => "waaaat"
Integer.omghi  # => "waaaat"
String.omghi   # => "waaaat"

# But sometimes a method only makes sense on one specific class
# Here, `File.directory?` makes sense, but `Integer.directory?` doesn't
# so, we want to put the directory method on the File class,
# but not on any other class.
# So, we put it on File's singleton class
File.directory? "/a/b/c" # => false

File.singleton_class         # => #<Class:File>
    .instance_methods(false) # => [:lutime, :link, :symlink, :readlink, :lchmod, :unlink, :rename, :umask, :mkfifo, :expand_path, :absolute_path, :absolute_path?, :realpath, :truncate, :basename, :...
    .grep(/directory/)       # => [:directory?]

# The most common way you will see this is to define methods on a class you create
# to the point that people call these "class methods" and think the `self` is part of the syntax
class MyClass
  def self.my_method
    123
  end
end

MyClass.my_method # => 123
