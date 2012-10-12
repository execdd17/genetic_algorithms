module GeneticAlgorithms

  #TODO: add input validation
  class Population

    attr_reader :chromosomes, :highest_score

    def initialize(chromosomes, fitness_function)
      @chromosomes      = chromosomes
      @fitness_function = fitness_function
      @highest_score    = nil
    end

    def self.random_chromosomes(total_chromosomes, chromosome_length)
      Array.new(total_chromosomes).map do 
        Chromosome.random(chromosome_length)
      end
    end

    def evolve
      weighted_chromosomes = @chromosomes.inject(Hash.new) do |memo, chromosome|
        memo[chromosome] = @fitness_function.call(chromosome)
        memo
      end

      @highest_score = weighted_chromosomes.values.max

      offspring = (0...(@chromosomes.size/2)).inject(Array.new) do |offspring|
        mates = Array.new(2).map do
          RouletteWheel.spin weighted_chromosomes
        end

        #TODO: change Chromosome#crossover to Chromosome#reproduce
        child_chromosome    = mates.first.crossover(mates.last)
        child_post_mutation = child_chromosome.map { |chromosome| chromosome.mutate }
        offspring          += child_post_mutation
      end

      Population.new offspring, @fitness_function
    end
  end
end
