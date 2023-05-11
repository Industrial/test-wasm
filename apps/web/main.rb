require "bundler/setup"
require "syntax_tree"

pp SyntaxTree.parse("1 + 1")
