# Write a class, that stores instances of other classes to perform their methods
# on every variable sent to 'emit'

class Event

  def initialize
    @funcs = {}
  end

  def subscribe(func)
    accessors = func.class.instance_methods(false).select { |m| m =~ /\w+=/ }.flat_map { |m| [m, m.to_s.chop.to_sym] }
    @funcs[func] = func.class.instance_methods(false) - accessors
  end

  def unsubscribe(func)
    @funcs.delete(func)
  end

  def emit(*args)
    @funcs.keys.each do |func|
      @funcs[func].each do |method|
        func.send(method.to_sym, *args)
      end
    end
  end

end

class Event_best

  def initialize
    @events = []
  end

  def subscribe(pr)
    @events.push pr
  end

  def unsubscribe(pr)
    @events.delete pr
  end

  def emit(*args)
    @events.each do |pr|
      pr.call(*args)
    end
  end

end
