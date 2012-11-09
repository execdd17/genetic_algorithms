$:.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))             
$:.unshift(File.join(File.dirname(__FILE__), '..', 'lib/genetic_algorithms'))

module GeneticAlgorithms
  require 'genetic_algorithms/chromosome'
  require 'genetic_algorithms/exceptions'
  require 'genetic_algorithms/roulette_wheel'
  require 'genetic_algorithms/population'


  Dir[File.join("./lib/genetic_algorithms/fitness_functions", "**/*.rb")].each do |f|
    require f
  end

  require 'genetic_algorithms/engine'
end
