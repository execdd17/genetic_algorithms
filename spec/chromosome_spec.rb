require 'spec_helper'
include GeneticAlgorithms

describe Chromosome do
  describe ".initialize" do
    it "should raise an exception when given non 0 and 1 characters" do
      lambda { Chromosome.new("01AB") }.should raise_error InvalidChromosome
    end

    it "should not raise an exception when given good data" do
      lambda { Chromosome.new("01110010") }.should_not raise_error 
    end
  end

  describe "#mutate" do
    subject { Chromosome.new "0000" }

    it "should flip bits when triggered" do
      subject.mutate(1.0).should == "1111"
    end

    it "should not flip bits when it isn't triggered" do
      subject.mutate(0.0).should == "0000"
    end
  end

  describe "#crossover" do
    before(:each) do
      @chromosome_1 = Chromosome.new "0000"
      @chromosome_2 = Chromosome.new "1111"
    end

    it "should alter the calling Chromosome's state when triggered" do
      offspring_1, offspring_2 = @chromosome_1.crossover(@chromosome_2, 1.0)
      offspring_1.should_not == @chromosome_1
    end
    
    it "should alter the receiver's Chromosome's state when triggered" do
      offspring_1, offspring_2 = @chromosome_1.crossover(@chromosome_2, 1.0)
      offspring_2.should_not == @chromosome_2
    end
    
    it "should not alter the receiver's Chromosome's state when not triggered" do
      offspring_1, offspring_2 = @chromosome_1.crossover(@chromosome_2, 0.0)
      offspring_2.should == @chromosome_2
    end

    it "should not alter the receiver's Chromosome's state when not triggered" do
      offspring_1, offspring_2 = @chromosome_1.crossover(@chromosome_2, 0.0)
      offspring_2.should == @chromosome_2
    end

    it "should raise an exception when trying to swap chromosomes of different sizes" do
      lambda do 
        @chromosome_1.crossover(Chromosome.new("01"), 0.0)
      end.should raise_error IncompatibleChromosomes
    end
  end

  describe ".random" do
    it "should return an instance of Chromosome" do
      Chromosome.random(10).is_a?(Chromosome).should == true
    end

    it "should be the length specified" do
      Chromosome.random(10).length.should ==  10
    end
  end
end
