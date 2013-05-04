require 'socket'

class Hermes
  @@URL = 'hackathon.hopto.org'
  @@PORTS = [23492, 23493]

  def initialize
    connect
    
  end

  def connect
    @connection = TCPSocket.open(@@URL, @@PORTS.sample)
  end

end
