class MarketplaceLogger
  def initialize
    @rails_logger = Rails.logger
    @mp_logger = Logger.new(STDOUT)
  end

  def method_missing(method, *args)
    @rails_logger.send(method, *args)
    @mp_logger.send(method, *args)
  end
end