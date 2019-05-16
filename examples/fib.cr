def fib_rec(n)
  if n == 0 || n == 1
    return 1
  end
  fib_rec(n - 1) + fib_rec(n - 2)
end

def fib_iter(n)
  if n < 2
    return 1
  end
  a, b = 1, 1
  i = 0
  while i < n - 1
    a, b = b, a + b
    i += 1
  end
  b
end

class BinTree(T)
  property value : T?
  property left : BinTree(T)?
  property right : BinTree(T)?

  def initialize(@value : T? = nil)
  end

  def insert(new_value : T)
    if (cur_value = @value).nil?
      @value = new_value
    else
      if new_value < cur_value
        if (left = @left).nil?
          @left = BinTree(T).new new_value
        else
          left.insert new_value
        end
      else
        if (right = @right).nil?
          @right = BinTree(T).new new_value
        else
          right.insert new_value
        end
      end
    end
  end

  def sorted
    unless (left = @left).nil?
      left.sorted
    end
    puts @value
    unless (right = @right).nil?
      right.sorted
    end
  end
end

def main
  puts fib_rec(10)
  puts fib_iter(10)

  tree = BinTree.new(4)
  tree.insert 5
  tree.insert 2
  tree.insert 3
  tree.insert 4
  tree.sorted
end

