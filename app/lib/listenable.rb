module Listenable
  def listeners
    @listeners ||= []
  end

  def add_listener(listener)
    listeners << listener
  end

  def remove_listener(listener)
    listeners.delete listener
  end

  def notify_listeners(event_name, *args)
    listeners.each do |listener|
      if listener.respond_to? event_name
        listener.__send__ event_name, *args
      end
    end
  end
end