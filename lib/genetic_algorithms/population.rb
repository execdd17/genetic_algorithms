module GeneticAlgorithms

  #TODO: add input validation
  class Population

    attr_reader :chromosomes, :highest_score

    def initialize(chromosomes)
      @chromosomes      = chromosomes
      @highest_score    = nil
    end

    def self.random_chromosomes(total_chromosomes, chromosome_length)
      Array.new(total_chromosomes).map do 
        Chromosome.random(chromosome_length)
      end
    end

    def evolve(&block)
      weighted_chromosomes = @chromosomes.inject(Hash.new) do |memo, chromosome|
        memo[chromosome] = block.call(chromosome)
        memo
      end

      @highest_score = weighted_chromosomes.values.max

      offspring = (0...(@chromosomes.size/2)).inject(Array.new) do |offspring|
        mates = Array.new(2).map do
          RouletteWheel.spin weighted_chromosomes
        end

        children_chromosomes    = mates.first.crossover(mates.last)
        children_post_mutation  = children_chromosomes.map { |chromosome| chromosome.mutate }
        offspring              += children_post_mutation
      end

      Population.new offspring
    end
  end
end