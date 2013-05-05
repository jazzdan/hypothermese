#TODO write something that accecpts the new demand and 
#returns the new values for each location for each type
#of server
class Controller

  #S and B values for North America
  @@NAS = 150 
  @@NAB = 150 

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

  def initialize(sa, sb, ja, jb, da, db)
    @@ServerAlpha = sa
    @@ServerBeta = sb
    @@JavaAlpha = ja
    @@JavaBeta = jb
    @@DatabaseAlpha = da
    @@DatabaseBeta = db 
  end

  #Expects an array of current demand
  def solve(demand, current)
    na = demand[5].to_i
    eu = demand[6].to_i
    ap = demand[7].to_i
    csNA, csEU, csAP, cjNA, cjEU, cjAP, cdNA, cdEU, cdAP = breakApartCurrent(current)
    sNA = keepPositive(csNA,changeInServers(na, "NA"))
    jNA = keepPositive(cjNA,changeInJava(na, "NA"))
    dNA = keepPositive(cdNA,changeInDatabases(na, "NA")) 
    sEU = keepPositive(csEU,changeInServers(eu, "EU"))
    jEU = keepPositive(cjEU,changeInJava(eu,"EU"))
    dEU = keepPositive(cdEU,changeInDatabases(eu, "EU"))
    sAP = keepPositive(csAP,changeInServers(ap, "AP"))
    jAP = keepPositive(cjAP,changeInJava(ap, "AP"))
    dAP = keepPositive(cdAP,changeInDatabases(ap, "AP"))
    [sNA,sEU,sAP,jNA,jEU,jAP,dNA,dEU,dAP].join(" ")
  end

  def keepPositive(current, change)
    if (current + change) < 0
      return 0
    else
     return change
    end
  end


  #@currentValue = the new demand for servers
  #@location = the location of the demand "NA"/"EU"/"AP"
  #@return = the change in servers
  def changeInServers(current, location)
    #get the s and b of the given location
    s,b = getSB(location)
    #calculate the future(current) s and bs
    nextS = calculateS(s,b,current,@@ServerAlpha,@@ServerBeta) 
    nextB = calculateB(nextS,s,b,@@ServerBeta)
    setSB(location, nextS, nextB)
    #figure out the number of connections two turns from now
    #this is the amount of time required to spin up a server
    future = nextS + nextB
    diffrence = future - (s+b)
    #return the number of servers to turn on/off
    (diffrence / @@ServerThreshold).round
  end 

  def changeInJava(current, location)
    s,b = getSB(location)
    nexts = calculateS(s,b,current,@@JavaAlpha,@@JavaBeta) 
    nextb = calculateB(nexts,s,b,@@JavaBeta)
    setSB(location, nexts, nextb)
    future = nexts + 3 * nextb
    diffrence = future - (s+b)
    (diffrence / @@JavaThreshold).round
  end

  def changeInDatabases(current, location)
    s,b = getSB(location)
    nexts = calculateS(s,b,current,@@DatabaseAlpha,@@DatabaseBeta) 
    nextb = calculateB(nexts,s,b,@@DatabaseBeta)
    setSB(location, nexts, nextb)
    future = nexts + 5 * nextb
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

  def breakApartCurrent(current)
    csNA = current[1].to_i
    csEU = current[2].to_i
    csAP = current[3].to_i
    cjNA = current[4].to_i
    cjEU = current[5].to_i
    cjAP = current[6].to_i
    cdNA = current[7].to_i
    cdEU = current[8].to_i
    cdAP = current[9].to_i
    return csNA, csEU, csAP, cjNA, cjEU, cjAP, cdNA, cdEU, cdAP
  end
end
