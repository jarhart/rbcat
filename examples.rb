#! /usr/bin/env ruby

$:.unshift File.expand_path('lib', File.dirname(__FILE__))

require 'compiler'

Compiler.run(['Hello World!', :print])

Compiler.run([3, 4, :dup, :*, :swap, :dup, :*, :+, :show_stack])

Compiler.run([
  'fact', [
    [2, :<],
    [:drop, 1],
    [:dup, :dec, :fact, :*],
    :ifte
  ], :def,

  6, :fact, :print
])

Compiler.run([

  'fib', [
    [1, :<],
    [:drop, 0],
    [ [2, :<],
      [:drop, 0, 1],
      [:dec, :fib, :dup, [:+], :dip, :swap],
      :ifte],
    :ifte
  ], :def,

  'show_fib', [
    :dup,
    [:fib], :dip,
    'fib(', :swap, :to_s, :+, ') is ', :+, :swap, :to_s, :+,
    :print
  ], :def,

  10, :show_fib
])

Compiler.run([
  'done?', [0, :eq], :def,
  'need_swap?', [:dup2, :<, :swap, :drop], :def,
  'mod_diff', [:tuck, :%], :def,
  'gcd', [
    [:need_swap?], [:swap], :ift,
    [:done?], [:drop], [:mod_diff, :gcd], :ifte
  ], :def,
  42, 70, :gcd, :show_stack
])
