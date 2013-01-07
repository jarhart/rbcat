require 'machine'
require 'language'
require 'st'

module Compiler

  module_function

  def initial_machine
    @initial_machine ||= Machine.new(Language.definitions)
  end

  def run(src)
    compile(src).(initial_machine)
  end

  def compile(src)
    ST.chain(src.map { |a| compile_word(a) })
  end

  def compile_word(arg)
    case arg
    when Symbol then Machine.perform(arg)
    when Array then Machine.push(compile(arg))
    else Machine.push(arg)
    end
  end
end
