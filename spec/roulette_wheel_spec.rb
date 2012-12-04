require 'spec_helper'
include GeneticAlgorithms

describe RouletteWheel do
  
  EPSILON = 0.000001
  SCORES  = {a: 10000, b: 1, c: 5000}

  describe "normalization" do
    context "ascending" do
      subject do 
        GeneticAlgorithms.fitness_function_type = :ascending
        RouletteWheel.new SCORES
      end

      before(:each) { @normalized = subject.normalized }

      it "returns values that have been mapped to Floats" do
        @normalized.values.all? { |value| value.is_a? Float }
      end

      it "returns values that add up to 1" do
        ((@normalized.values.inject(:+) - 1).abs < EPSILON).should == true
      end

      it "correctly calculates the probability for the first key" do
        @normalized[:a].should eql (SCORES[:a].to_f / SCORES.values.inject(:+))
      end
      
      it "correctly calculates the probability for the second key" do
        @normalized[:b].should eql (SCORES[:b].to_f / SCORES.values.inject(:+))
      end

      it "correctly calculates the probability for the third key" do
        @normalized[:c].should eql (SCORES[:c].to_f / SCORES.values.inject(:+))
      end
    end

    context "descending" do

      subject do 
        GeneticAlgorithms.fitness_function_type = :descending
        RouletteWheel.new SCORES 
      end

      before(:each) { @normalized = subject.normalized }

      it "returns values that have been mapped to Floats" do
        @normalized.values.all? { |value| value.is_a? Float }
      end

      it "returns values that add up to 1" do
        ((@normalized.values.inject(:+) - 1).abs < EPSILON).should == true
      end

      it "correctly calculates the probability for all keys" do
        pending
      end

    end
  end

  describe "#spin" do
    SPINS = 1000
    
    context "ascending" do
      subject do 
        GeneticAlgorithms.fitness_function_type = :ascending
        RouletteWheel.new SCORES
      end

      it "should return the highest score on a long enough timeline" do
        results = {a: 0, b: 0, c: 0}
        SPINS.times { results[subject.spin] += 1 }

        (results[:a] > results[:b] and results[:a] > results[:c]).should == true
      end
    end

    context "descending" do
      subject do
        GeneticAlgorithms.fitness_function_type = :descending
        RouletteWheel.new SCORES 
      end

      it "should return the highest score on a long enough timeline" do
        results = {a: 0, b: 0, c: 0}
        ap subject.normalized
        SPINS.times { results[subject.spin] += 1 }

        (results[:b] > results[:a] and results[:b] > results[:c]).should == true
      end
    end
  end
end
