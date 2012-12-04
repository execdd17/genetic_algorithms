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

  require 'genetic_algorithms/chromosome'
  require 'genetic_algorithms/exceptions'
  require 'genetic_algorithms/roulette_wheel'
  require 'genetic_algorithms/population'
  require 'genetic_algorithms/engine'
  
  attr_accessor :num_generations, :population_size, :fitness_function_type
  attr_accessor :chromosome_length

  def configure 
    raise ArgumentError, "A block must be given" unless block_given?
    yield self
  end
end

#GeneticAlgorithms.config[:fitness_function_type] = :descending
#GeneticAlgorithms.config[:num_generations]  = 10

#GeneticAlgorithms::Engine.new.start(0) do |chromosome|        
#  chromosome.each_char.inject(0) do |accum, char|     
#    accum += 1 if char == GeneticAlgorithms::Chromosome::OFF             
#    accum                                             
#  end                                                 
#end                                                   
