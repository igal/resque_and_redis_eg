require 'logger'
require 'rubygems'
require 'resque'

class Ping
  LOG = Logger.new('log/pingpong.log')

  @queue = 'pingpong'

  def self.perform(counter=0)
    sleep 1
    LOG.info("Ping #{counter}")
    Resque.enqueue(Pong, counter+1)
  end
end

class Pong
  LOG = Logger.new('log/pingpong.log')

  @queue = 'pingpong'

  def self.perform(counter=0)
    sleep 1
    LOG.info("Pong #{counter}")
    Resque.enqueue(Ping, counter+1)
  end
end
