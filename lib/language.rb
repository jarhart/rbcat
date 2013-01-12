require 'machine'
require 'st'

class Language
  include Machine::STs

  def self.definitions
    @definitions ||= self.new.definitions
  end

  def initialize
    @definitions = {

      :noop =>  noop,

      :drop =>  pop & noop,

      :dup =>   peek >>-> x {
                push(x) },

      :swap =>  pop >>-> x {
                pop >>-> y {
                push(x) &
                push(y) }},

      :inc =>   pop >>-> x {
                push(x + 1) },

      :dec =>   pop >>-> x {
                push(x - 1) },

      :+ =>     pop >>-> x {
                pop >>-> y {
                push(y + x) }},

      :- =>     pop >>-> x {
                pop >>-> y {
                push(y - x) }},

      :* =>     pop >>-> x {
                pop >>-> y {
                push(y * x) }},

      :/ =>     pop >>-> x {
                pop >>-> y {
                push(y / x) }},

      :and =>   pop >>-> x {
                pop >>-> y {
                push(y && x) }},

      :or =>    pop >>-> x {
                pop >>-> y {
                push(y || x) }},

      :not =>   pop >>-> x {
                push(!x) },

      :eq =>    pop >>-> x {
                peek >>-> y {
                push(y == x) }},

      :< =>     pop >>-> x {
                peek >>-> y {
                push(y < x) }},

      :> =>     pop >>-> x {
                peek >>-> y {
                push(y > x) }},

      :cat =>   pop >>-> x {
                pop >>-> y {
                push(y & x) }},

      :apply => pop >>-> w {
                w },

      :times => pop >>-> w {
                pop >>-> x {
                ST.repeat(x, w) }},

      :dip =>   pop >>-> w {
                pop >>-> x {
                w &
                push(x) }},

      :keep =>  pop >>-> w {
                peek >>-> x {
                w &
                push(x) }},

      :ifte =>  pop >>-> a {
                pop >>-> c {
                pop >>-> p {
                p & pop >>-> b {
                b ? c : a }}}},

      :ift =>   pop >>-> c {
                pop >>-> p {
                p & pop >>-> b {
                b ? c : noop }}},

      :to_s =>  pop >>-> x {
                push x.to_s },

      :def =>   pop >>-> d {
                pop >>-> n {
                define(n, d) }},

      :call =>  pop >>-> n {
                perform(n) },

      :print => pop.map { |x| puts x },

      :show_stack => stack_dump.map { |a| p a }
    }
  end

  attr_reader :definitions

end
