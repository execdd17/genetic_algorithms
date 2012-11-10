$:.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))             
$:.unshift(File.join(File.dirname(__FILE__), '..', 'lib/genetic_algorithms'))

require 'logging'

%W{Population Chromosome RouletteWheel}.each do |logger_type|
  log = Logging.logger["GeneticAlgorithms::#{logger_type}"]
  log.level = :debug
  log.add_appenders Logging.appenders.file("results.log")
end

module GeneticAlgorithms
  require 'genetic_algorithms/chromosome'
  require 'genetic_algorithms/exceptions'
  require 'genetic_algorithms/roulette_wheel'
  require 'genetic_algorithms/population'

  ff_path = File.join(File.expand_path("..", __FILE__), "genetic_algorithms/fitness_functions")
  Dir[File.join ff_path, "**/*.rb"].each do |f|
    require f
  end

  require 'genetic_algorithms/engine'
end
