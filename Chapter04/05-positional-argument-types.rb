# works!
def a(x, y=2, z)
  [x, y, z]
end
a(1, 3)
# => [1, 2, 3]

# Doesn't work, SyntaxError 
def a(x=1, y, z=2)
end

# x is the leading argument 
# y optional argument 
# z is the post argument
def a(x, y=2, z)
end

eval(<<END)
  def a(x=1, y, z=2)
  end
END

def a(x, y=nil)
end

# y is the post arguments
def a(x=nil, y)
end

def a(y)
end

a(2)

def a(x=nil, y)
end

a(1, 2)

def identifier(column, table=nil)
end

def identifier(table=nil, column)
end
