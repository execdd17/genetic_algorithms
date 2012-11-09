module GeneticAlgorithms

  #TODO: add input validation
  class Population

    attr_reader :chromosomes, :highest_score, :best_solution

    def initialize(chromosomes)
      @chromosomes = chromosomes
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

      highest_weighted = Hash[[ weighted_chromosomes.invert.sort.first ]].invert
      @best_solution = highest_weighted.keys.first
      @highest_score = highest_weighted.values.first

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
