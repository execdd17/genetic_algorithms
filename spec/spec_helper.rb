require 'simplecov'

SimpleCov.start do
  add_filter "/spec/"
end

RSpec.configure do |config|
  config.tty = true
  config.color = true
end

require './lib/genetic_algorithms'
