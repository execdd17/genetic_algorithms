require 'spec_helper'
include GeneticAlgorithms

describe Engine do
  subject { Engine.new }

  # TODO: DRY out this code
  describe "#start" do
    context "AllOffSample fitness function" do
      it "returns a hash" do
        subject.start("AllOffSample").is_a?(Hash).should == true
      end

      it "returns the best solution as a Chromosome" do
        subject.start("AllOffSample").keys.first.is_a?(Chromosome).should == true
      end

      it "returns the best score as a Fixnum" do
        subject.start("AllOffSample").values.first.is_a?(Fixnum).should == true
      end
    end

    context "AlternatingOnOffSample fitness function" do
      it "returns a hash" do
        subject.start("AlternatingOnOffSample").is_a?(Hash).should == true
      end

      it "returns the best solution as a Chromosome" do
        subject.start("AlternatingOnOffSample").keys.first.is_a?(Chromosome).should == true
      end

      it "returns the best score as a Fixnum" do
        subject.start("AlternatingOnOffSample").values.first.is_a?(Fixnum).should == true
      end
    end
  end
end
