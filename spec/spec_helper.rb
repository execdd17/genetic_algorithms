require 'simplecov'

SimpleCov.start do
  add_filter "/spec/"
end

require './lib/genetic_algorithms'

GeneticAlgorithms.configure do |config|
  config.population_size    = 10
  config.chromosome_length  = 10
  config.num_generations    = 10
end
