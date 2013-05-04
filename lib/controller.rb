class Contorller

  @@NAS
  @@EUS
  @@APS
  @@ServerAlpha
  @@JavaAlpha
  @@DatabaseAlpha

  def nextServerState(currentValue, location)
    threshold = 200
    s = getS(loaction)
    nextS = @@ServerAlpha * currentValue + (1-@@ServerAlpha) * s
    diffrence = nextS - s
    setS(location, nextS)
    (diffrence / threshold).round
  end 

  def getS(location)
    if location == "NA"
      @@NAS
    elsif location == "EU"
      @@EUS
    else
      @@APS
    end
  end
  
  def setS(location, nextS)
    if location == "NA"
      @@NAS = nextS
    elsif location == "EU"
      @@EUS = nextS
    else
      @@APS = nextS
    end
  end

end 
