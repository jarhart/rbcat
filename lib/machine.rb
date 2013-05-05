require 'stack'
require 'state'

class Machine

  module States
    def noop
      @noop ||= State[nil]
    end

    def push(x)
      State.update { |m| m.push(x) }
    end

    def pop
      @pop ||= State.get >>-> m { State.set(m.pop).map { m.top } }
    end

    def peek
      @peek ||= State.get.map { |m| m.top }
    end

    def define(name, st)
      State.update { |m| m.define(name, st) }
    end

    def perform(name)
      State.get >>-> m { m.lookup(name) }
    end

    def stack_dump
      @stack_dump ||= State.get.map { |m| m.stack_dump }
    end
  end

  def initialize(definitions, stack = Stack.empty)
    @definitions = definitions
    @stack = stack
  end

  def push(x)
    Machine.new(@definitions, @stack.push(x))
  end

  def top
    @stack.top
  end

  def pop
    Machine.new(@definitions, @stack.pop)
  end

  def define(name, st)
    Machine.new(@definitions.merge(name.to_sym => st), @stack)
  end

  def lookup(name)
    @definitions[name.to_sym]
  end

  def stack_dump
    @stack.to_a
  end

  extend States
end
