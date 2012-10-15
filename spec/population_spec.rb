require 'spec_helper'
include GeneticAlgorithms

# NOTE: changing the constants can alter the tests dramatically
describe Population do

  POPULATION_SIZE   = 100   # the number of chromosomes
  CHROMOSOME_LENGTH = 30    
  NUM_GENERATIONS   = 50
  
  before(:each) do 
    @chromosomes = Population.random_chromosomes POPULATION_SIZE, CHROMOSOME_LENGTH
  end

  describe ".random_chromosomes" do
    it "should return an array of chromosomes" do
      @chromosomes.all? { |element| element.is_a? Chromosome }.should == true
    end

    it "should return the correct number of chromosomes" do
      @chromosomes.length.should == POPULATION_SIZE
    end

    it "should return chromosomes of the correct length" do
      @chromosomes.all? { |chromosome| chromosome.length == CHROMOSOME_LENGTH }.should == true
    end
  end

  describe "#evolve" do
    
    before(:each) do

    # +1 for each zero bit (The best solution is all zeros)
      fitness_function = lambda do |chromosome| 
        chromosome.each_char.inject(0) do |accum, char|
          accum += 1 if char == "0"
          accum
        end
      end

      @population = Population.new @chromosomes, fitness_function
      @best_score = CHROMOSOME_LENGTH
    end

    it "should return a new population" do
      next_gen = @population.evolve
      (next_gen.is_a? Population and not next_gen.eql? @population).should == true
    end

    it "should find a solution that is within 10% of the ideal one" do
      highest_score = 0

      (0...NUM_GENERATIONS).inject(@population) do |newest_population, i|
        next_gen = newest_population.evolve

        if newest_population.highest_score > highest_score
          highest_score = newest_population.highest_score 
          break if highest_score == @best_score
        end

        next_gen
      end

      (highest_score * 1.1 >= @best_score).should == true
    end
  end
end
