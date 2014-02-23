require 'spec_helper'
include GeneticAlgorithms

describe Engine do

  BEST_SCORE = 10

  describe '.configure' do
    before(:all) do
      Engine.configure do |config|
        config.population_size    = 23
        config.chromosome_length  = 15
        config.num_generations    = 7
      end
    end

    it 'sets the population size from a config block' do
      Engine.instance.population_size.should be 23
    end

    it 'sets the chromosome length from a config block' do
      Engine.instance.chromosome_length.should be 15
    end

    it 'sets the num generations from a config block' do
      Engine.instance.num_generations.should be 7
    end
  end

  describe "#start" do

    shared_examples "a fitness function" do
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

    context "AllOffSample fitness function" do
      subject do
        Engine.instance.start(BEST_SCORE) do |chromosome|
          chromosome.each_char.inject(0) do |accum, char|         
            accum += 1 if char == Chromosome::OFF                 
            accum                                                 
          end
        end
      end

      it_should_behave_like "a fitness function"
    end

    context "AlternatingOnOffSample fitness function" do

      subject do 
        Engine.instance.start(BEST_SCORE) do |chromosome|
          (0...chromosome.length).inject(0) do |accum, index|                      
            accum += 1 if index % 2 == 0 and chromosome[index] == Chromosome::ON   
            accum += 1 if index % 2 == 1 and chromosome[index] == Chromosome::OFF  
            accum                                                                  
          end                                                                      
        end
      end

      it_should_behave_like "a fitness function"
    end
  end
end
