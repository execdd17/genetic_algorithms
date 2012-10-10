require 'genetic_algorithms/natural_hash'

module GeneticAlgorithms
  class RouletteWheel

    def self.spin chromosomes_and_scores
      chromosomes_and_scores      = NaturalHash[ chromosomes_and_scores ]
      total                       = chromosomes_and_scores.values.inject(:+)
      prng                        = rand

      normalized = chromosomes_and_scores.map do |chromosome, score| 
        [chromosome, score.to_f/total]
      end

      normalized = normalized.sort_by { |chromosome, probability| probability }

      accumulator = 0
      normalized.each_pair do |chromosome, probability| 
        return chromosome if prng <= probability + accumulator
        accumulator += probability
      end
    end
  end
end
