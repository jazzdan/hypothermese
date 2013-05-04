#TODO write something that accecpts the new demand and 
#returns the new values for each location for each type
#of server
class Controller

  #S and B values for North America
  @@NAS = 200 
  @@NAB = 100 
  @@NAServers = 1

  #S and B values for Europe
  @@EUS = @@NAS
  @@EUB = @@NAB 
  
  #S and B values for Asia-Pac
  @@APS = @@NAS
  @@APB = @@NAB 

  #the alpha and beta values for web servers
  @@ServerAlpha = 0.75
  @@ServerBeta = 0.25
  #The "max" size of a server
  @@ServerThreshold = 200

  #the alpha and beta values for java serves
  @@JavaAlpha = 0.75
  @@JavaBeta = 0.25
  #The "max" size of a java server
  @@JavaThreshold = 500

  #the alpha and beta values for databases
  @@DatabaseAlpha = 0.75
  @@DatabaseBeta = 0.25
  #the "max" size of a database server
  @@DatabaseThreshold = 1000

  def initialize(costs)
    #do things with the costs and the alpha and betas
  end

  #Expects an array of current demand
  def solve(demand)
    na = demand[5].to_i
    eu = demand[6].to_i
    ap = demand[7].to_i
    sNA = changeInServers(na, "NA")
    jNA = changeInJava(na, "NA")
    dNA = changeInDatabases(na, "NA") 
    sEU = changeInServers(eu, "EU")
    jEU = changeInJava(eu,"EU")
    dEU = changeInDatabases(eu, "EU")
    sAP = changeInServers(ap, "AP")
    jAP = changeInJava(ap, "AP")
    dAP = changeInDatabases(ap, "AP")
    [sNA,sEU,sAP,jNA,jEU,jAP,dNA,dEU,dAP].join(" ")
  end

  #@currentValue = the new demand for servers
  #@location = the location of the demand "NA"/"EU"/"AP"
  #@return = the change in servers
  def changeInServers(currentValue, location)
    #get the s and b of the given location
    s,b = getSB(location)
    #calculate the future(current) s and bs
    nextS = calculateS(s,b,currentValue,@@ServerAlpha,@@ServerBeta) 
    nextB = calculateB(nextS,s,b,@@ServerBeta)
    setSB(location, nextS, nextB)
    #figure out the number of connections two turns from now
    #this is the amount of time required to spin up a server
    future = nextS + 2 * nextB
    diffrence = future - (s+b)
    #return the number of servers to turn on/off
    (diffrence / @@ServerThreshold).round
  end 

  def changeInJava(currentValue, location)
    s,b = getSB(location)
    nexts = calculateS(s,b,currentValue,@@JavaAlpha,@@JavaBeta) 
    nextb = calculateB(nexts,s,b,@@JavaBeta)
    setSB(location, nexts, nextb)
    future = nexts + 4 * nextb
    diffrence = future - (s+b)
    (diffrence / @@JavaThreshold).round
  end

  def changeInDatabases(currentValue, location)
    s,b = getSB(location)
    nexts = calculateS(s,b,currentValue,@@DatabaseAlpha,@@DatabaseBeta) 
    nextb = calculateB(nexts,s,b,@@DatabaseBeta)
    setSB(location, nexts, nextb)
    future = nexts + 6 * nextb
    diffrence = future - (s+b)
    (diffrence / @@DatabaseThreshold).round
  end

  def calculateS(s,b,x,alpha,beta)
    alpha * x + (1-alpha) * (s+b)
  end

  def calculateB(st,s,b,beta)
    beta * (st - s) + (1 - beta) * b
  end 

  def getSB(location)
    if location == "NA"
      return  @@NAS,@@NAB
    elsif location == "EU"
      return @@EUS,@@EUB
    else
      return @@APS,@@APB
    end
  end
  
  def setSB(location, nextS, nextB)
    if location == "NA"
      @@NAS = nextS
      @@NAB = nextB
    elsif location == "EU"
      @@EUS = nextS
      @@EUB = nextB
    else
      @@APS = nextS
      @@APB = nextB
    end
  end

end 
