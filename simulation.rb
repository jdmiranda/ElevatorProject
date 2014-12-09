require_relative 'person'
require_relative 'elevator'
require_relative 'strategy'


class Simulation
  include(PersonMod, ElevatorMod, StrategyMod)
  attr_reader :elevator, :sleepers, :people, :people_count, :over, :time, :max_floor, :strat, :total
  def initialize
    @time = 1
    @sleepers = []
    @people = []
    @over = false
    @total = 0
  end

  def run(file, strategy)
    #puts 'starting to run'
    gen_data(file)
    @elevator = Elevator.new
    @strat = Strategy.new(@elevator, strategy)
    @elevator.set_floor(1, 1, @max_floor)
    start_running
    report_analytics
  end

  def report_analytics
    #puts 'reporting average time'
    puts self.average_wait_time
  end

  def gen_data(file)
    #puts 'gen data '
    a = []
    File.open(file).each_line do |l|
      f = l.split
      a.push(f.map {|x| x.to_i})
    end

    @max_floor = a[0].join.to_i
    a.delete_at(0)
    gen_people(a)

  end

  def gen_people(a)
    #puts 'gen people'
    @people_count = a.size
    a.each do |element|
      e = element
      person = Person.new(e[0], e[1], e[2], e[3])
      @sleepers.push(person)
      end
  end


  def average_wait_time
    @total/@people_count
  end


  def call(person)
    #puts 'call person'
    @elevator.callers.push(person)
    @sleepers.delete(person)

  end

  def debark(person)
    #puts 'debark person'
    @elevator.passengers.delete(person)
    @people.push(person)
    person.arrival_time(@time)
    person.is_home
    @total += person.get_total_time
  end

  def board(person)
    #puts 'board person'
    @elevator.passengers.push(person)
    @elevator.callers.delete(person)
  end

  def running
    #puts 'running'
    @sleepers.each {|person| if person.call_time.eql?(time) or person.call_time < @time then call(person) end}
    @elevator.callers.each {|person| if person.origin.eql?(@elevator.floor) then board(person) end}
    @elevator.passengers.each {|person| if person.dest.eql?(@elevator.floor) then debark(person) end}

    @strat.execute
    @time += 1

    #puts "sleepers: #{@sleepers.size} passengers: #{@elevator.passengers.size} time: #{@time} "
    #puts "callers: #{@elevator.callers.size} people: #{@people.size} floor: #{@elevator.floor}"
   # sleep(2)
  end

  def everyone_awake?
    #puts 'checking awake'
    if @sleepers.size.eql?(0) then true else false end
  end

  def everyone_home?
    #puts 'checking home'
    if (@people.size.eql?(@people_count) and @people.each { |p| p.home }) then
      true
    else
      false
    end
  end

  def over?
    #puts 'are we over?'
    if everyone_home? and everyone_awake? then  return true end

  end

  def start_running
    puts 'start running'
    until self.over? do running end
  end
end

