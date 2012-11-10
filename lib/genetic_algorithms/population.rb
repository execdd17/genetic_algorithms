module GeneticAlgorithms

  #TODO: add input validation
  class Population

    attr_reader :chromosomes, :highest_score, :best_solution

    def initialize(chromosomes)
      @chromosomes  = chromosomes
      @logger       = Logging.logger[self.class]
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

      highest_weighted = Hash[[ weighted_chromosomes.invert.sort.last ]].invert
      @best_solution = highest_weighted.keys.first
      @highest_score = highest_weighted.values.first

      roulette_wheel = RouletteWheel.new weighted_chromosomes

      offspring = (0...(@chromosomes.size)).inject(Array.new) do |offspring|
        mates = Array.new(2).map do
          roulette_wheel.spin
        end

        child_chromosome    = mates.first.crossover(mates.last)
        offspring          << child_chromosome
      end

      @logger.info "Highest Score in population: #@highest_score"
      @logger.info "Best Solution in population: #@best_solution"

      Population.new offspring
    end
  end
end
