module GeneticAlgorithms
  class Chromosome < String

    OFF, ON = "0", "1"

    def initialize(string)
      unless string.each_char.all? { |s| s == OFF or s == ON }
        raise InvalidChromosome, "A chromosome can only have 0's and 1's" 
      end

      @logger = Logging.logger[self.class]
      super(string)
    end

    def self.random(length)
      chromosome = (0...length).inject(String.new) do |chromosome, i|
        chromosome += (rand(2) == 0 ? OFF : ON)
      end

      Chromosome.new chromosome
    end

    def mutate(prob=0.05)
      @logger.debug "MUTATION: Starting on\t#{self}"

      chromosome = self.each_char.map do |char|
        mutate?(prob) ? flip(char) : char
      end.join

      @logger.debug "MUTATION: Result\t\t#{chromosome}"
      Chromosome.new chromosome
    end

    def flip(char)
      @logger.debug "MUTATION: Triggered on #{self}" if char == ON
      char == ON ? OFF : ON
    end
    
    def crossover(chromosome, probability=0.7)
      unless self.size == chromosome.size
        raise IncompatibleChromosomes, "Both chromosomes need to be the same size"
      end

      offspring = self

      if crossover?(probability)
        index       = rand(0...length)
        offspring   = Chromosome.new self[0...index] + chromosome[index...length]
        @logger.debug "CROSSOVER: Using the first #{index} bits from #{self} and " +
                      "the last #{length - index} bits from #{chromosome}"
        @logger.debug "CROSSOVER: Result\t#{offspring}"
      end

      offspring.mutate  
    end
    
    def check_prob(prob)
      rand <= prob
    end
    
    alias_method :crossover?, :check_prob
    alias_method :mutate?,    :check_prob
  end
end
