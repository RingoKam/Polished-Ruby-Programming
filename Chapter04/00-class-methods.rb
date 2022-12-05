# these are all 4 ways to implement singleton method

# 1 Best used
class Foo
  def self.bar
    :baz
  end
end

class Foo
end

def Foo.bar
  :baz
end

def (Foo = Class.new).bar
  :baz
end

# 2 reserver for advance work
# ex: modifying the method visibility
class Foo
  class << self
    def bar
      :baz
    end
  end
end

# --

# 3 use instance_eval
class Foo
end

class << Foo
  def bar
    :baz
  end
end

Foo.instance_eval do
  def bar
    :baz
  end
end

class Foo
  def self.bar
    :baz
  end
end

class Foo
  class << self
    private

    def bar
      :baz
    end

    alias baz bar
    remove_method :bar
  end
end

class Foo
  def self.bar
    :baz
  end
  private_class_method :bar

  singleton_class.alias_method :baz, :bar
  singleton_class.remove_method :bar
end

# 4 define_singleton_method
class Foo
  define_singleton_method(:bar) do
    :baz
  end
end
