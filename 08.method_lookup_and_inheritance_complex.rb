# Method invocation:
# * evaluate the left hand side of the `.` to get the receiver
#   * if there is no dot, the receiver is `self`
# * evaluate the arguments to get their values
# * look up the receiver's class
# * look for the method name in the class' instance methods
#   * if it DNE, go to the superclass and look there
#   * when we reach the top (BasicObject), we know the method DNE
#     and pass the method call information to `receiver.method_missing`
#     which, by default, explodes with a NoMethodError
# * put a new binding on the callstack
#   * with `self` set to the receiver
#   * and the arguments as local variables based on the parameters
#   * then evaluate the code from the method in that binding

class W
  def zomg() '1' + wtf  end
  def wtf()  '2'        end
  def bbq()  '3'        end
end

class X < W
  def zomg() super      end
  def wtf()  '4' + bbq  end
  def bbq()  super      end
end

class Y < X
  def zomg() '6' + super  end
  def wtf()  '7' + super  end
  def bbq()  '8' + super  end
end

W.new.zomg # => "12"
X.new.zomg # => "143"
Y.new.zomg # => "617483"
