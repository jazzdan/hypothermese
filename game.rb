#TODO PASS IN THE RIGHT ANSWERS
require 'lib/hermes.rb'
require 'lib/controller.rb'

@@COSTS = [0,0,0]

def loop(alpha, beta)
  @@HERMES = Hermes.new
  @@COSTS = @@HERMES.getCosts
  #initialize the controller
  @@CONTROLLER = Controller.new(alpha,beta,alpha,beta,alpha,beta)
  #read the first config
  config = @@HERMES.start 
  #while we get config and not end
  while config[0] != "END"
    #WE HAVE CONFIG so ask for demand
    demand = @@HERMES.demand
    #ask for dist
    dist   = @@HERMES.dist
    #ask for the profit
    profit = @@HERMES.profit
    #send the 'answer' and recive config
      config = @@HERMES.control(@@CONTROLLER.solve(demand,config))
  end
  @@HERMES.closeSocket
end
