require 'spec_helper'
include GeneticAlgorithms

describe RouletteWheel do
  EPSILON = 0.000001
  SCORES  = {a: 3, b: 1, c: 2}

  subject { RouletteWheel.new SCORES }

  describe "#normalize" do
    context "ascending" do
      GeneticAlgorithms.config[:fitness_function_type] = :ascending
      before(:each) { @normalized = subject.normalize }

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
      GeneticAlgorithms.config[:fitness_function_type] = :descending
      before(:each) { @normalized = subject.normalize }

      it "returns values that have been mapped to Floats" do
        @normalized.values.all? { |value| value.is_a? Float }
      end

      it "returns values that add up to 1" do
        ((@normalized.values.inject(:+) - 1).abs < EPSILON).should == true
      end

      it "correctly calculates the probability for all keys" do
        @normalized[:b].should eql 0.5
      end

    end
  end

  describe "#spin" do

    SPINS = 1000

    it "should return the highest score on a long enough timeline" do
      pending
      results = {a: 5, b: 2, c: 1}
      SPINS.times { results[subject.spin] += 1 }

      (results[:a] > results[:b] and results[:a] > results[:c]).should == true
    end
  end
end
