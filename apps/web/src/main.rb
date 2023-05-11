# frozen_string_literal: true

require './second'

luckiness = %w[Lucky Unlucky].sample

puts "You are #{luckiness}"

def derp
  puts 'LOL'
end

derp
