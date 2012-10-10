module GeneticAlgorithms
  class NaturalHash < Hash
    def map
      result = super()
      hash_structure?(result) ? NaturalHash[ result ] : result
    end

    def sort_by
      NaturalHash[ super ]
    end

    private 

    def hash_structure?(obj)
      if obj.is_a? Array and not obj.empty?
        return true if obj.all? { |i| i.is_a? Array and i.length == 2}
      end

      false
    end
  end
end
