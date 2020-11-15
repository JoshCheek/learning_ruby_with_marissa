stack = []
stack.push "hi"
stack.push "there"
stack # => ["hi", "there"]
stack.pop # => "there"
stack.pop # => "hi"

queue = []
queue.push "hi"
queue.push "there"
queue # => ["hi", "there"]
queue.shift # => "hi"
queue.shift # => "there"
