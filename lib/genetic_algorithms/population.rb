require 'awesome_print'

module GeneticAlgorithms

  #TODO: add input validation and defensive coding
  class Population

    attr_reader :chromosomes

    def initialize size, fitness_function, options={}
      @chromosomes      = options[:chromosomes] || Array.new(size)
      @fitness_function = fitness_function

      seed_population if options[:first_generation]
    end

    def evolve
      weighted_chromosomes = @chromosomes.inject(Hash.new) do |memo, chrom|
        memo[chrom] = @fitness_function.call(chrom)
        memo
      end

      offspring = (0...(@chromosomes.size/2)).inject(Array.new) do |memo, i|
        mates = Array.new(2).map do
          RouletteWheel.spin weighted_chromosomes
        end

        chromosome_recombination = mates.first.crossover(mates.last)
        memo += chromosome_recombination.map { |chromosome| chromosome.mutate }
      end

      Population.new @chromosomes.size, @fitness_function, chromosomes: offspring
    end

    def add_chromosome chromosome
      @chromosomes << chromosome
    end

    private

    #TODO: the chromsome length and the number of chromosomes
    # in a population are not the same. Fix it
    def seed_population
      @chromosomes.map! { Chromosome.random @chromosomes.size }
    end
  end
end

fitness_function = lambda do |chromosome|  
  score = 0

  chromosome.each_char { |char| score += 1 if char == "0" }
  score
end

p = GeneticAlgorithms::Population.new 6, fitness_function, first_generation: true
ap p.evolve
