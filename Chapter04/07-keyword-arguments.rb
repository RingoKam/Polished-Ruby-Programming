# Hash
foo({:bar=>1})

# Hash (without braces)
foo(:bar=>1)

def foo(options)
end

def foo(options={})
end

# avoid hash being allocated by 
# providing one outside the method
OPTIONS = {}.freeze
def foo(options=OPTIONS)
end

foo(:bar=>1)
# however if we are providing a value, 
# 
BAR_OPTIONS = {:bar=>1}.freeze
foo(BAR_OPTIONS)

def foo(options=OPTIONS)
  bar = options[:bar]
end

# :baz keyword ignored
foo(:baz=>2)

def foo(options=OPTIONS)
  options = options.dup
  bar = options.delete(:bar)
  raise ArgumentError unless options.empty?
end

def foo(bar: nil)
end

# No allocations
foo
foo(bar: 1)

# This allocates a hash
hash = {bar: 1}

# But in Ruby 3, calling a method with a
# keyword splat does not
foo(**hash)

foo(baz: 1)
# ArgumentError (unknown keyword: :baz)

def foo(*args, **kwargs)
  [args, kwargs]
end

# Ruby 2 
# Keywords treated as keywords, good!
foo(bar: 1)
# => [[], {:bar=>1}]

# Hash treated as keywords, bad!
foo({bar: 1})
# => [[], {:bar=>1}]

# Ruby 3
# Keywords treated as keywords, good!
foo(bar: 1)
# => [[], {:bar=>1}]

# Hash treated as positional argument, good!
foo({bar: 1})
# => [[{:bar=>1}], {}]

# Always allocates a hash
def foo(**kwargs)
end

def foo(**kwargs)
  bar(**kwargs)
end

def bar(**kwargs)
  baz(**kwargs)
end

def baz(key: nil)
  key
end

# 2 hash allocations
foo

# positional argument is used instead
def foo(options=OPTIONS)
  bar(options)
end

def bar(options=OPTIONS)
  baz(options)
end

def baz(options=OPTIONS)
  key = options[:key]
end

# 0 hash allocations
foo

# no allocation 
# but difficult to maintain
def foo(key: nil)
  bar(key: key)
end

def bar(key: nil)
  baz(key: key)
end

def baz(key: nil)
  key
end

# 0 hash allocations
foo

def foo(bar, **nil)
end

# original 
def foo(bar)
  bar
end

foo(bar: 1)
# => {:bar=>1}

def foo(bar, baz: nil)
  bar
end

foo(bar: 1)
# ArgumentError (wrong number of arguments)

def foo(bar, **nil)
  bar
end

foo(bar: 1)
# ArgumentError (no keywords accepted)

def foo(options=OPTIONS)
  bar(options)
  baz(options)
end

def bar(options)
  options[:bar]
end

def baz(options)
  options[:baz]
end

def foo(**kwargs)
  bar(**kwargs)
  baz(**kwargs)
end

def bar(bar: nil)
  bar
end

def baz(baz: nil)
  baz
end
# explode if i provide keyword argument 
foo(bar: 1, baz: 2)

# doesnt explode but hard to maintain 
def foo(bar: nil, baz: nil)
  bar(bar: bar)
  baz(baz: baz)
end

def bar(bar: nil)
  bar
end

def baz(baz: nil)
  baz
end

def foo(**kwargs)
  bar(**kwargs)
  baz(**kwargs)
end

def bar(bar: nil, baz: nil)
  bar
end

def baz(baz: nil, bar: nil)
  baz
end
# doesn't blow up but unused variable

def foo(**kwargs)
  bar(**kwargs)
  baz(**kwargs)
end

def bar(bar: nil, **)
  bar
end

def baz(baz: nil, **)
  baz
end
# works but bad for performance as it need to allocate 3 times

# Positional
def foo(bar=nil)
end

# Keyword
def foo(bar: nil)
end

# Positional
def foo(bar=nil, baz=nil)
end

# Keyword
def foo(bar: nil, baz: nil)
end

# Positional
foo(nil, 1)

# Keyword
foo(baz: 1)
