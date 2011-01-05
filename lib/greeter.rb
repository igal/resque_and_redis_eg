require 'logger'

class Greeter
  LOG = Logger.new('log/greeter.log')

  @queue = 'greeter'

  def self.perform(entity)
    LOG.info("Hello #{entity}")
  end
end
