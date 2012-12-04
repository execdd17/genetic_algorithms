module GeneticAlgorithms
  class Engine 
    
    def initialize
      @population_size    = GeneticAlgorithms.population_size
      @chromosome_length  = GeneticAlgorithms.chromosome_length
      @num_generations    = GeneticAlgorithms.num_generations

      @chromosomes = Population.random_chromosomes @population_size, @chromosome_length
      @population  = Population.new @chromosomes
    end 

    def start(best_possible_score, &fitness_function)
      highest_score = Population.initial_high_score
      best_gen      = nil
      
      (0...@num_generations).inject(@population) do |newest_population, i|
        next_gen = newest_population.evolve(&fitness_function)

        ap newest_population.best_solution
        ap newest_population.highest_score
        ap Population.compare_score(highest_score, newest_population.highest_score)
        if Population.compare_score(highest_score, newest_population.highest_score) == -1
          highest_score, best_gen = newest_population.highest_score, newest_population
          break if highest_score == best_possible_score
        end

        next_gen
      end
    
      {best_gen.best_solution => best_gen.highest_score}
    end
  end
end
