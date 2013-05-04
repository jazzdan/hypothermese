require 'socket'
require 'timeout'

class Hermes
  @@URL = 'hackathon.hopto.org'
  @@PORTS = [23492, 23493]
  @@TEAM_NAME = 'StorganManley'
  @@READ_LENGTH = 4096


  def initialize
    @connection = connect
    write('INIT ' + @@TEAM_NAME)
    read(6)
    write('RECD')

    message, client_address = @connection.recv(@@READ_LENGTH)

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
    read = @connection.read(length)
    puts read
    read
  end

end
