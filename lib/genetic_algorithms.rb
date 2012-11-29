$:.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))             
$:.unshift(File.join(File.dirname(__FILE__), '..', 'lib/genetic_algorithms'))

require 'logging'
require 'awesome_print'

%W{Population Chromosome RouletteWheel}.each do |logger_type|
  log = Logging.logger["GeneticAlgorithms::#{logger_type}"]
  log.level = :debug
  log.add_appenders Logging.appenders.file("results.log")
end

module GeneticAlgorithms
  extend self

  @config = {
    population_size:        10,
    chromosome_length:      10,
    num_generations:        5,
    fitness_function_type:  :ascending
  }
  
  attr_accessor :config

  require 'genetic_algorithms/chromosome'
  require 'genetic_algorithms/exceptions'
  require 'genetic_algorithms/roulette_wheel'
  require 'genetic_algorithms/population'
  require 'genetic_algorithms/engine'
end

#GeneticAlgorithms.config[:fitness_function_type] = :descending
#GeneticAlgorithms.config[:num_generations]  = 10

#GeneticAlgorithms::Engine.new.start(0) do |chromosome|        
#  chromosome.each_char.inject(0) do |accum, char|     
#    accum += 1 if char == GeneticAlgorithms::Chromosome::OFF             
#    accum                                             
#  end                                                 
#end                                                   
