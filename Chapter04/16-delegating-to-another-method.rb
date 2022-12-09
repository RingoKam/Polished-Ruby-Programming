def foo(*args, **kwargs, &block)
  [args, kwargs, block]
end

def bar(*args, **kwargs, &block)
  [args, kwargs, block]
end

# keep old method, show warnring and call the new method
def foo(*args, **kwargs, &block)
  warn("foo is being renamed to bar", uplevel: 1)
  bar(*args, **kwargs, &block)
end

# shortcut with Ruby 2.7
def foo(...)
  warn("foo is being renamed to bar", uplevel: 1)
  bar(...)
end

def foo(*args, &block)
  warn("foo is being renamed to bar", uplevel: 1)
  bar(*args, &block)
end

def foo(*args, &block)
  warn("foo is being renamed to bar", uplevel: 1)
  bar(*args, &block)
end
ruby2_keywords(:foo) if respond_to?(:ruby2_keywords, true)
