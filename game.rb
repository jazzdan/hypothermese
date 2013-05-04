require 'lib/hermes.rb'

@@COSTS = [0,0,0]

def loop 
  @@HERMES = Hermes.new 
  @@COSTS = @@HERMES.getCosts
  keepGoing = @@HERMES.start 
  while(keepGoing != "END")
    config = @@HERMES.config
    demand = @@HERMES.demand
    dist   = @@HERMES.dist
    profit = @@HERMES.profit
    @@HERMES.control(solveShit)
  end
end
