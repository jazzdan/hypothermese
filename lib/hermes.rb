require 'socket'
require 'timeout'

class Hermes
  @@URL = 'hackathon.hopto.org'
  #only one port works? and it's this one
  @@PORTS = [23493]
  @@TEAM_NAME = 'StorganManley'
  @@READ_LENGTH = 4096


  def initialize
    @connection = connect
    write('INIT ' + @@TEAM_NAME)
    read(6)
    write('RECD')
    costs, client_address = read(@@READ_LENGTH) 
    costs
  end

  def start
    write('START')
    read(@@READ_LENGTH)
  end

  #alias the next to config to know what you're expecting
  #to get back. not sure if this is actually a good idea
  #but it works :p
  def config
    self.next
  end

  def demand
    self.next
  end

  def dist
    self.next
  end

  def profit
    self.next
  end

  def control(wna, weu, wap, jna, jeu, jap, dna, deu, dap)
    write(wna.to_s + " " + weu.to_s + " " + wap.to_s + " " +
          jna.to_s + " " + jeu.to_s + " " + jap.to_s + " " +
          dna.to_s + " " + deu.to_s + " " + dap.to_s + " ")
    answer, client_address = read(@@READ_LENGTH)
    answer 
  end

  def next
    write('RECD')
    costs, client_address = read(@@READ_LENGTH)
    costs
  end

  def connect
    TCPSocket.new(@@URL, @@PORTS.sample)
  end

  def write(msg)
    puts 'Sending: ' + msg.to_s
    @connection.write(msg)
  end

  def read(length)
    puts 'Reading ' + length.to_s + ' bytes.'
    read = @connection.recv(length)
    puts read
    read
  end

end
