module GeneticAlgorithms
  module FitnessFunctions
    module AllOffSample

      def best_possible_score
        @chromosome_length
      end
  
      def fitness_function
        lambda do |chromosome|
          chromosome.each_char.inject(0) do |accum, char|
            accum += 1 if char == "0"
            accum
          end
        end
      end
    end
  end
end
