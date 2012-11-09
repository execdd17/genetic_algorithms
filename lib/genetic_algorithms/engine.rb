module GeneticAlgorithms
  class Engine 
    include FitnessFunctions::AllOffIdeal
    
    def initialize(population_size=100, chromosome_length=30, num_generations=50)
      @population_size    = population_size 
      @chromosome_length  = chromosome_length
      @num_generations    = num_generations

      @chromosomes = Population.random_chromosomes @population_size, @chromosome_length
      @population  = Population.new @chromosomes
    end 
  end
end
