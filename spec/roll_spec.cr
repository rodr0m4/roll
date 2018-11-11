require "./spec_helper"

describe Roll do
  describe "Rolling" do
    roller = Roll::Roller.new

    describe "1d6" do
      it "yields a value between 1 and 6" do
        results = (0..100000).map { |_| roller.roll(6) }

        results.each { |n| 
          n.should be <= 6 
          n.should be >= 1
        }
      end
    end

    # it "2d6 should call Roller::roll twice" do
      # dunno how Mock works :(
    # end

    describe "2d6" do
      results = (0..100000).map { |_| roller.roll(2, 6) }

      it "yield two values" do
        results.should be_a(Array(Array(Int32)))
      end

      it "sum of values is between 2 and 12" do
        results.each { |values| 
          n = values.sum()

          n.should be >= 2
          n.should be <= 12 
        }
      end
    end

    describe "stats" do
      results = (0..100000).map { |_| roller.stats() }

      it "yields a 6-sized list with values between 3 and 18" do
        results.each { |stats| 
          stats.size.should eq(6)

          stats.each { |stat|
            stat.should be >= 3
            stat.should be <= 18
          }
        }
      end
    end

    describe "safe_stats" do
      results = (0..100000).map { |_| roller.safe_stats() }

      it "has a value of 15 or more" do
        results.each { |stats|
          bigger_than_14 = stats.select { |stat| stat > 14 }
          bigger_than_14.size.should be >= 1
        }
      end
    end
  end 

  describe "Parsing" do
    parser = Roll::Parser.new

    describe "\"1d6\"" do
      die_str = "1d6"

      it "parses to a {1, 6}" do
        die_tuple = parser.parse(die_str)

        die_tuple.should be_a(Tuple(Int32, Int32))
        die_tuple[0].should eq(1)
        die_tuple[1].should eq(6)
      end
    end
  end
end