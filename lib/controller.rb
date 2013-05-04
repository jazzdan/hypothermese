class Controller

  #S and B values for North America
  @@NAS = 200 
  @@NAB = 0

  #S and B values for Europe
  @@EUS = @@NAS
  @@EUB = 0 
  
  #S and B values for Asia-Pac
  @@APS = @@NAS
  @@APB = 0

  #the alpha and beta values for web servers
  @@ServerAlpha = 0.25
  @@ServerBeta = 0.25

  #the alpha and beta values for java serves
  @@JavaAlpha = 0.25
  @@JavaBeta = 0.25

  #the alpha and beta values for databases
  @@DatabaseAlpha = 0.25
  @@DatabaseBeta = 0.25

  def changeInServers(currentValue, location)
    threshold = 200
    s,b = getSB(location)
    nextS = calculateS(s,b,currentValue,@@ServerAlpha,@@ServerBeta) 
    nextB = calculateB(nextS,s,b,@@ServerBeta)
    puts nextS
    puts @@NAS
    diffrence = nextS - s
    setSB(location, nextS, 0)
    (diffrence / threshold).round
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
