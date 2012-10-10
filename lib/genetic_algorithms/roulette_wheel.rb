module GeneticAlgorithms
  class NaturalHash < Hash
    def map
      result = super()

      if result.is_a? Array and result.all? { |i| i.is_a? Array and i.length == 2}
        return NaturalHash[ result ]
      end

      result
    end
  end

  class RouletteWheel

    #TODO: THis works, but it is SERIOULY ugly
    def self.spin prob_dist
      prng  = rand
      total = prob_dist.values.inject(:+)

      normalized = prob_dist.map { |obj, prob| [obj, prob.to_f/total] }
      normalized = Hash[ normalized ].sort_by { |obj, prob| prob }

      accum = 0
      Hash[ normalized ].each_pair do |obj, prob| 
        return obj if prng <= prob + accum
        accum += prob
      end
    end
  end
end
