

module ElevatorMod
class Elevator

  attr_reader :callers, :passengers, :floor, :max_floor, :min_floor, :direction


  def initialize
    #puts 'init elevator'
    @callers = []
    @passengers = []
    @direction = 'up'
  end

  def set_floor(floor, min, max)
    #puts 'setting floor'
    @floor = floor
    @max_floor = max.to_i
    @min_floor = min
  end

  def should_change_dir?
   if  @floor.eql?(@max_floor) or @floor.eql?(@min_floor) then true
     else false
   end
  end

  def change_dir
    if @direction.eql?('up') then @direction = 'down'
      elsif @direction.eql?('down') then @direction = 'up'
    end
  end

  def go_up
   # puts 'going up'
    @floor += 1 if @floor < @max_floor
    if @passengers.any? then  @passengers.each{|p| p.cur_floor = @floor} end

  end

  def go_down
   # puts 'going down'
    @floor = @floor - 1 if @floor > @min_floor
    if @passengers.any? then  @passengers.each {|p| p.cur_floor = @floor} end
  end

  def self.remove_passenger(person)
    @passengers.delete_if {|p| p.id.eql?(person.id)}
  end

  def self.add_caller(person)
    @callers.push(person)
  end

  def callers_time_till_home
    if @callers.any? then @callers.each.inject(0) {|sum, p| sum + p.time_till_home} end
  end

  def pass_time_till_home
    if @passengers.any? then @callers.each.inject(0) {|sum, p| sum + p.time_till_home} end
  end



end
end







