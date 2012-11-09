module GeneticAlgorithms
  module FitnessFunctions
    module AllOffIdeal

      def best_score
        @chromosome_length
      end
  
      #TODO: this should return the best solution as well as its score
      def start
        highest_score = 0

        (0...@num_generations).inject(@population) do |newest_population, i|
          
          next_gen = newest_population.evolve do |chromosome|
            chromosome.each_char.inject(0) do |accum, char|
              accum += 1 if char == "0"
              accum
            end
          end

          if newest_population.highest_score > highest_score
            highest_score = newest_population.highest_score 
            break if highest_score == self.best_score
          end

          next_gen
        end

        highest_score
      end
    end
  end
end
