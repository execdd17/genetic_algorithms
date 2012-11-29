require 'spec_helper'
include GeneticAlgorithms

describe Engine do
  
  # TODO: DRY out this code
  describe "#start" do
    context "AllOffSample fitness function" do

      subject do 
        Engine.new.start(10) do |chromosome|
          chromosome.each_char.inject(0) do |accum, char|         
            accum += 1 if char == Chromosome::OFF                 
            accum                                                 
          end
        end
      end                                                     

      it "returns a hash" do
        subject.is_a?(Hash).should == true
      end

      it "returns the best solution as a Chromosome" do
        subject.keys.first.is_a?(Chromosome).should == true
      end

      it "returns the best score as a Fixnum" do
        subject.values.first.is_a?(Fixnum).should == true
      end
    end

    context "AlternatingOnOffSample fitness function" do

      subject do 
        Engine.new.start(10) do |chromosome|
          (0...chromosome.length).inject(0) do |accum, index|                      
            accum += 1 if index % 2 == 0 and chromosome[index] == Chromosome::ON   
            accum += 1 if index % 2 == 1 and chromosome[index] == Chromosome::OFF  
            accum                                                                  
          end                                                                      
        end
      end                                                     

      it "returns a hash" do
        subject.is_a?(Hash).should == true
      end

      it "returns the best solution as a Chromosome" do
        subject.keys.first.is_a?(Chromosome).should == true
      end

      it "returns the best score as a Fixnum" do
        subject.values.first.is_a?(Fixnum).should == true
      end
    end
  end
end
