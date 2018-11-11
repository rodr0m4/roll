require "./roll.cr"

first_arg = ARGV[0]
parser = Roll::Parser.new
roller = Roll::Roller.new

case first_arg
when "stats"
  puts roller.stats()
when "safe_stats", "colville"
  puts roller.safe_stats()
else
  die_tuple = parser.parse(first_arg)
  puts roller.roll(die_tuple)
end