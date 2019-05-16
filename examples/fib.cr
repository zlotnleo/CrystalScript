def fib_rec(n)
  if n == 0 || n == 1
    return 1
  end
  fib_rec(n - 1) + fib_rec(n - 2)
end



def main
  puts fib_rec(10)
end
