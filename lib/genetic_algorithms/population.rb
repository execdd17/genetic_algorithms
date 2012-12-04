module GeneticAlgorithms
  class Population

    attr_reader :chromosomes, :highest_score, :best_solution

    def initialize(chromosomes)
      @chromosomes  = chromosomes
      @logger       = Logging.logger[self.class]
    end

    def self.initial_high_score
      fft = GeneticAlgorithms.fitness_function_type
      fft == :ascending ? -Float::INFINITY : Float::INFINITY
    end

    def self.compare_score(first_score, second_score)
      puts "fs #{first_score} ss #{second_score}"
      case GeneticAlgorithms.fitness_function_type
      when :ascending then
        return -1 if first_score  <   second_score
        return  0 if first_score  ==  second_score
        return  1 if first_score  >   second_score
      when :descending then
        return -1 if first_score  >   second_score
        return  0 if first_score  ==  second_score
        return  1 if first_score  <   second_score
      else
        raise "Invalid type"
      end
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

      highest_weighted = best_pair weighted_chromosomes
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

    private

    def best_pair weighted_chromosomes
      score_to_chrom = weighted_chromosomes.invert.sort # lowest score first
      fft = GeneticAlgorithms.fitness_function_type
      fft == :ascending ? (Hash[[ score_to_chrom.last ]].invert) : 
                          (Hash[[ score_to_chrom.first ]].invert)
    end
  end
end
