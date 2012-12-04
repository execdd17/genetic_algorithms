require 'genetic_algorithms/natural_hash'

module GeneticAlgorithms
  class RouletteWheel
    def initialize chromosomes_and_scores
      @chromosomes_and_scores = NaturalHash[ chromosomes_and_scores ]
      @logger                 = Logging.logger[self]
      @type                   = GeneticAlgorithms.fitness_function_type
    end

    def spin 
      normalized.inject(0) do |accumulator, (chromosome, probability)| 
        if rand <= probability + accumulator
          @logger.debug "Choosing #{chromosome} with probability #{probability}"
          return chromosome 
        end

        accumulator += probability
      end
    end

    def normalized
      self.send("normalize_#{@type}")
    end

    private 

    def normalize_ascending
      normalize_helper { @chromosomes_and_scores }
    end

    # remap fitness function scores
    def normalize_descending
      normalize_helper do 
        @chromosomes_and_scores.map do |chromosome, score| 
          score == 0 ? [chromosome, score] : [chromosome, 1/score.to_f]
        end
      end
    end
    
    def normalize_helper
      chroms_and_probs = yield 

      total = chroms_and_probs.values.inject(:+)
      normalized = chroms_and_probs.map do |chromosome, score| 
        [chromosome, score.to_f/total]
      end

      normalized.sort_by { |chromosome, probability| probability }
    end
  end
end
