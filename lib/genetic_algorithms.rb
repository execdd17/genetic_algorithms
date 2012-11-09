$:.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))             
$:.unshift(File.join(File.dirname(__FILE__), '..', 'lib/genetic_algorithms'))

module GeneticAlgorithms
  require 'genetic_algorithms/chromosome'
  require 'genetic_algorithms/exceptions'
  require 'genetic_algorithms/roulette_wheel'
  require 'genetic_algorithms/population'
  require 'genetic_algorithms/fitness_functions/all_off_ideal'
  require 'genetic_algorithms/engine'
end
