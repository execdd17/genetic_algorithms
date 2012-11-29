require 'spec_helper'
include GeneticAlgorithms

describe RouletteWheel do
  EPSILON = 0.000001
  SCORES  = {a: 3, b: 1, c: 2}


  describe "normalization" do
    context "ascending" do
      subject do 
        GeneticAlgorithms.config[:fitness_function_type] = :ascending
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
        @normalized[:a].should eql (SCORES[:a].to_f / SCORES.values.inject(:+))
        @normalized[:b].should eql (SCORES[:b].to_f / SCORES.values.inject(:+))
        @normalized[:c].should eql (SCORES[:c].to_f / SCORES.values.inject(:+))
      end
    end

    context "descending" do
      subject do 
        GeneticAlgorithms.config[:fitness_function_type] = :descending
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

    SPINS = 500

    it "should return the highest score on a long enough timeline" do
      pending
      results = {a: 5, b: 2, c: 1}
      SPINS.times { results[subject.spin] += 1 }

      (results[:a] > results[:b] and results[:a] > results[:c]).should == true
    end
  end
end
