
module StrategyMod
  class Strategy
    attr_reader :strategy, :elevator

    def initialize(elevator, strategy)
      puts 'init strat'
      @direction = 'up'
      @strategy = strategy
      @elevator = elevator

    end

    def set_elevator(elevator)
      @elevator = elevator
    end

    def execute
      #puts 'execute'
      get_strat1 if strategy.equal?(:strat1)
    end



=begin
    def get_strat
      if @direction.eql?('up')
        if @elevator.floor < @elevator.max_floor then @elevator.go_up
        puts "floor #{@elevator.floor} < max #{@elevator.max_floor}"
        else @direction = 'down' and @elevator.go_down end
      elsif @direction.eql?('down')
        if  @elevator.floor > @elevator.min_floor then @elevator.go_down
        puts "floor #{@elevator.floor} > min #{@elevator.min_floor}"
        else @direction = 'up'and @elevator.go_up end
      end
    end
=end

=begin
    def get_strat1

    if @direction.eql?('up') then @elevator.go_up
      else @elevator.go_down
      end

    if @elevator.floor.to_i.eql?(@elevator.max_floor.to_i) then @direction = 'down'
    if @elevator.floor.to_i.eql?(@elevator.min_floor.to_i) then @direction = 'up' end
      end
  end
=end

    def get_strat1
      if @elevator.should_change_dir? then @elevator.change_dir end
      if @elevator.direction.eql?('up') then @elevator.go_up
        elsif @elevator.direction.eql?('down') then @elevator.go_down
      end
    end

  end
end


