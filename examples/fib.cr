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

# module MemFib
#   @@cache = [1, 1]

#   def self.fib()
# end

def main
  puts fib_rec(10)
  puts fib_iter(10)
end

