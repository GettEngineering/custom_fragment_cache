module CustomFragmentCache
  class Configuration
    attr_accessor :enabled, :expiration_time

    def initialize
      @enabled = true
      @expiration_time = 1.hour
    end
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configuration=(config)
    @configuration = config
  end

  def self.configure
    yield(configuration) if block_given?
  end
end