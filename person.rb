module PersonMod
class Person
  attr_reader :call_time, :origin, :dest, :id, :total_time, :arrival_time, :home

  def initialize(id, call, origin, dest)
    @id = id
    @home = false
    @call_time = call
    @origin = origin
    @dest = dest
    @total_time = 0

    #puts 'init person'
  end

  def self.id(id)
    @id = id
  end

  def self.call_time(time)
    @call_time = time
  end

  def self.origin(origin)
    @origin = origin
  end

  def self.dest(dest)
    @dest = dest
  end

  def arrival_time(time)
    @arrival_time = time
  end

  def get_total_time
    @total_time =  @arrival_time.to_i - @call_time.to_i
  end

  def is_home
    #puts 'setting home'
    @home = true
    self.get_total_time
  end

end

end