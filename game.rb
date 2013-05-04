#TODO PASS IN THE RIGHT ANSWERS
require 'lib/hermes.rb'

@@COSTS = [0,0,0]

def loop 
  @@HERMES = Hermes.new 
  @@COSTS = @@HERMES.getCosts
  #read the first config
  config = @@HERMES.start 
  #while we get config and not end
  while config != "END"
    #WE HAVE CONFIG so ask for demand
    demand = @@HERMES.demand
    #ask for dist
    dist   = @@HERMES.dist
    #ask for the profit
    profit = @@HERMES.profit
    #send the 'answer' and recive control
    answer = Controller.new(profit)
    control = @@HERMES.control(solveShit)
  end
end
