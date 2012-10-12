require 'spec_helper'
include GeneticAlgorithms

describe NaturalHash do
  
  subject { NaturalHash[ {a:1, b:2} ] }

  describe "#map" do
    it "should return a NaturalHash when mapping a 2d array" do
      subject.map { |k,v| [k,v] }.is_a?(NaturalHash).should == true
    end

    it "should return the normal value when mapping anything else" do
      subject.map { |k,v| "test" }.is_a?(NaturalHash).should == false
    end
  end

  describe "#sort_by" do
    it "should return a NaturalHash" do
      subject.sort_by { |k,v| v }.is_a?(NaturalHash).should == true
    end
  end
end
