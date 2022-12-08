
def foo(bar, *)
end

# ignore any argument after, 
# useful if you want to persist the rest of the args
# for base class
def foo(bar, *)
  bar = 2
  super
end

def a(*bar)
end

def a(bar)
end

def a(bar=[])
end

EMPTY_ARRAY = [].freeze
def a(bar=EMPTY_ARRAY)
end

EMPTY_ARRAY = [].freeze
def a(bar=EMPTY_ARRAY)
  bar << 1
end

EMPTY_ARRAY = [].freeze
def a(bar=EMPTY_ARRAY)
  bar = bar.dup
  bar << 1
end

a(:foo, :bar)

a([:foo, :bar])

a(array)

a(*array)

def a(x, *y)
end

# to pass into z, we need to provide y!
def a(x, y=nil, *z)
end

def a(*y, z)
end

# make sense if we try to implement move
def mv(source, *sources, dir)
  sources.unshift(source)
  sources.each do |source|
    move_into(source, dir)
  end
end

mv("foo", "dir")
mv("foo", "bar", "baz", "dir")
