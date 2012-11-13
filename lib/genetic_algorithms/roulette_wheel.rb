require 'genetic_algorithms/natural_hash'

module GeneticAlgorithms
  class RouletteWheel
    def initialize chromosomes_and_scores
      chromosomes_and_scores  = NaturalHash[ chromosomes_and_scores ]
      total                   = chromosomes_and_scores.values.inject(:+)
      @logger                 = Logging.logger[self]

      normalized = chromosomes_and_scores.map do |chromosome, score| 
        [chromosome, score.to_f/total]
      end

      @normalized = normalized.sort_by { |chromosome, probability| probability }
    end

    # TODO: use inject here instead of each_pair
    def spin 
      accumulator, prn = 0, rand

      @normalized.each_pair do |chromosome, probability| 
        if prn <= probability + accumulator
          @logger.debug "Choosing #{chromosome} with probability #{probability}"
          return chromosome 
        end

        accumulator += probability
      end
    end
  end
end
