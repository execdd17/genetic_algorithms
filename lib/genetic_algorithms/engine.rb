require 'singleton'

module GeneticAlgorithms
  class Engine
    include Singleton

    attr_accessor :population_size, :chromosome_length, :num_generations

    def self.configure(&block)
      return nil unless block_given?
      block.call(self.instance)
    end

    def initialize
      @population_size    ||= 10
      @chromosome_length  ||= 10
      @num_generations    ||= 5

      @chromosomes = Population.random_chromosomes @population_size, @chromosome_length
      @population  = Population.new @chromosomes
    end 

    def start(best_possible_score, &fitness_function)
      highest_score, best_gen = 0, nil
      
      (0...@num_generations).inject(@population) do |newest_population, i|
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
