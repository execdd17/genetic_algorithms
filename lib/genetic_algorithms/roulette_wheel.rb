require 'genetic_algorithms/natural_hash'
require 'awesome_print'

module GeneticAlgorithms
  class RouletteWheel
    def initialize chromosomes_and_scores
      @chromosomes_and_scores = NaturalHash[ chromosomes_and_scores ]
      @logger                 = Logging.logger[self]
      @type                   = GeneticAlgorithms.config[:fitness_function_type]
      ap chromosomes_and_scores
      puts "There are #{chromosomes_and_scores.size} key value pairs"
      @normalized             = normalize
    end

    #TODO: THIS METHOD DOES NOT CALCULATE DESCENDING CORRECTLY
    def normalize
      total = @chromosomes_and_scores.values.inject(:+)
      normalized = @chromosomes_and_scores.map do |chromosome, score| 
        [chromosome, score.to_f/total]
      end

      asc_normalized = normalized.sort_by { |chrom, prob| prob }
      
      #desc_normalized = asc_normalized.map { |chrom, prob| [chrom, 1-prob] }
      #total = desc_normalized.values.inject(:+)
      #desc_normalized = desc_normalized.map do |chrom, score|
      #  [chrom, score.to_f/total]
      #end

      puts "ascending"
      ap asc_normalized

      puts "descending"
      ap desc_normalized

      @type == :ascending ? asc_normalized : desc_normalized
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
