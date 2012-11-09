module GeneticAlgorithms
  module FitnessFunctions
    module AlternatingOnOffSample

      def best_possible_score
        @chromosome_length
      end
  
      def fitness_function
        lambda do |chromosome|
          (0...chromosome.length).inject(0) do |accum, index|
            accum += 1 if index % 2 == 0 and chromosome[index] == Chromosome::ON
            accum += 1 if index % 2 == 1 and chromosome[index] == Chromosome::OFF
            accum
          end
        end
      end
    end
  end
end
