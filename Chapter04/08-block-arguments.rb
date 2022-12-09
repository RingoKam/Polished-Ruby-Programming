def foo(bar)
  # takes in a block that will accept 2 arg
  yield(bar, @baz)
end

foo(1) do |bar, baz|
  bar + baz
end

def foo(bar)
  # no problem, but will break with lambda
  yield(bar, @baz, @initial || 0)
end

foo(1) do |bar, baz|
  bar + baz
end

foo(1) do |bar, baz, initial|
  bar + baz + initial
end

adder = -> (bar, baz) do
  bar + baz
end

# Worked before, now broken
# lambda block are strict on its # of args
foo(1, &adder)

# To get around it, we introduce a new keyword arg
# to differentiate between old and new
def foo(bar, include_initial: false)
  if include_initial
    yield(bar, @baz, @initial || 0)
  else
    yield(bar, @baz)
  end
end

def foo(bar, &block)
  case block.arity
  when 2, -1, -2
    yield(bar, @baz)
  else
    yield(bar, @baz, @initial || 0)
  end
end
