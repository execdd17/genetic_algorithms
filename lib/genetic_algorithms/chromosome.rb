module GeneticAlgorithms
  class Chromosome < String

    OFF, ON = "0", "1"

    def initialize(string)
      unless string.each_char.all? { |s| s == "0" or s == "1" }
        raise InvalidChromosome, "A chromosome can only have 0's and 1's" 
      end

      super(string)
    end

    def mutate(prob=0.01)
      self.each_char.map do |char|
        mutate?(prob) ? flip(char) : char
      end.join
    end

    def flip(char)
      char == ON ? OFF : ON
    end
    
    def crossover(chromosome, probability=0.7)

      unless self.size == chromosome.size
        raise IncompatibleChromosomes, "Both chromosomes need to be the same size"
      end

      first_offspring, second_offspring = self, chromosome

      if crossover?(probability)
        index   = rand(0...length)

        first_offspring  = self[0...index] + chromosome[index...length]
        second_offspring = chromosome[0...index] + self[index...length]
      end

      
      [first_offspring, second_offspring]
    end
    
    def check_prob(prob)
      rand <= prob
    end
    
    alias_method :crossover?, :check_prob
    alias_method :mutate?,    :check_prob
  end
end
