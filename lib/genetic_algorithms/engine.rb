module GeneticAlgorithms
  class Engine

    class << self
      attr_accessor :population_size, :chromosome_length, :num_generations
    end

    def self.configure(&block)
      block.call(self) if block_given?

      Engine.population_size    = 10  unless Engine.population_size
      Engine.chromosome_length  = 10  unless Engine.chromosome_length
      Engine.num_generations    = 5   unless Engine.num_generations
    end

    def initialize
      Engine.configure
      chromosomes = Population.random_chromosomes Engine.population_size, Engine.chromosome_length
      @population = Population.new chromosomes
    end 

    def start(best_possible_score, &fitness_function)
      highest_score, best_gen = 0, nil
      
      (0...Engine.num_generations).inject(@population) do |newest_population, i|
        next_gen = newest_population.evolve(&fitness_function)

        if newest_population.highest_score > highest_score
          highest_score, best_gen = newest_population.highest_score, newest_population
          break if highest_score == best_possible_score
        end

        next_gen
      end

      {best_gen.best_solution => best_gen.highest_score}
    end
  end
end
