require 'stack'
require 'st'

class Machine

  module STs
    def noop
      @noop ||= ST[nil]
    end

    def push(x)
      ST.update { |m| m.push(x) }
    end

    def pop
      ST.get >>-> m { ST.set(m.pop).map { m.top } }
    end

    def peek
      @peek ||= ST.get.map { |m| m.top }
    end

    def define(name, st)
      ST.update { |m| m.define(name, st) }
    end

    def perform(name)
      ST.get >>-> m { m.lookup(name) }
    end

    def stack_dump
      @stack_dump ||= ST.get.map { |m| m.stack_dump }
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

  extend STs
end
