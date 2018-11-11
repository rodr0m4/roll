# TODO: Write documentation for `Roll`
module Roll
  class Roller
    include Roll

    def initialize
      @r = Random.new
    end

    def roll(denomination : Int32) : Int32
      @r.rand(denomination) + 1 
    end

    def roll(number : Int32, denomination : Int32) : Array(Int32)
      (0...number).map { |_| self.roll(denomination) }
    end

    def roll(die_tuple : Tuple(Int32, Int32)) : Array(Int32)
      self.roll(die_tuple[0], die_tuple[1])
    end

    # Syntax is clunky AF for passing methods as block, specifically for methods
    # with generics. Sad :(
    def stats()    
      (0...6).map { |_| 
          self.roll(4, 6)
                .sort { |a, b| b <=> a }
                .first(3)
                .sum
      }.sort { |a, b| b <=> a }
    end

    def safe_stats()
      stats = [] of Int32
  
      # No Array::any method, this really sucks
      while stats.select { |s| s > 15 }.size < 1
        stats = self.stats()
      end

      stats
    end
  end

  class Parser
    include Roll

    def parse(die_str : String) : Tuple(Int32, Int32)
      die_array = die_str.split(/d/)

      {die_array[0].to_i, die_array[1].to_i}
    end
  end
end