# rbcat

An experiment in defining a purely functional concatenative language
interpreter in Ruby, just for fun.

Programs are written as arrays of words:
  * Symbols are interpreted as the names of words defined in the language.
  * Arrays are interpreted as quoted words that are pushed onto the stack.
  * All other values are interpreted as literals and are pushed onto the stack.

Examples:

    ["Hello World!", :print]

This program pushes the string "Hello World!" onto the stack and then prints
it.

    [3, 4, :dup, :*, :swap, :dup, :*, :+]

This program calculates the sum of the squares 3 and 4, leaving 25 on the top
of the stack.
