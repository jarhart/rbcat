module Pushable
  def push(x)
    Stack.new(x, self)
  end
end

class Stack
  include Pushable

  def self.empty
    EmptyStack.instance
  end

  def initialize(top, pop)
    @top = top
    @pop = pop
  end

  attr_reader :top, :pop

  def to_a
    pop.to_a + [top]
  end
end

class EmptyStack
  include Pushable

  def self.instance
    @instance ||= self.new
  end

  def top
    raise 'top of empty stack'
  end

  def pop
    raise 'pop on empty stack'
  end

  def to_a
    []
  end
end
