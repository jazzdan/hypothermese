#TODO PASS IN THE RIGHT ANSWERS
require 'lib/hermes.rb'
require 'lib/controller.rb'

@@COSTS = [0,0,0]

def loop 
  @@HERMES = Hermes.new 
  @@COSTS = @@HERMES.getCosts
  #initialize the controller
  alpha = 0.8
  beta = 0.4
  @@CONTROLLER = Controller.new(alpha,beta,alpha,beta,alpha,beta)
  #read the first config
  config = @@HERMES.start 
  i = 0
  #while we get config and not end
  while config[0] != "END"
    #WE HAVE CONFIG so ask for demand
    demand = @@HERMES.demand
    #ask for dist
    dist   = @@HERMES.dist
    #ask for the profit
    profit = @@HERMES.profit
    #send the 'answer' and recive config
    if i%10==0
      config = @@HERMES.control(@@CONTROLLER.solve(demand,config))
    else
      config = @@HERMES.control("0 0 0 0 0 0 0 0 0 0")
    end
    i = i+1 
  end
  @@HERMES.closeSocket
end
