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
      @population = Population.new @chromosomes
      @best_score = CHROMOSOME_LENGTH
    end
    
    it "should accept a block that holds the fitness function" do
      lambda do
        @population.evolve { |chromosome| rand(@best_score) }
      end.should_not raise_error
    end
    
    it "should return a population" do
      next_gen = @population.evolve { |chromosome| rand(chromosome.length) }
      next_gen.is_a?(Population).should == true
    end

    it "should return a population different than the one before evolution" do
      next_gen = @population.evolve { |chromosome| rand(chromosome.length) }
      next_gen.eql?(@population).should == false
    end
  end
end
