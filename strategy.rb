
module StrategyMod
  class Strategy
    attr_reader :strategy, :elevator

    def initialize(elevator, strategy)
      #puts 'init strat'
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
      get_strat2 if strategy.equal?(:strat2)
    end


    def get_strat1
      if @elevator.should_change_dir? then @elevator.change_dir end
      if @elevator.direction.eql?('up') then @elevator.go_up
      elsif @elevator.direction.eql?('down') then @elevator.go_down
      end
    end

    def get_strat2
      f = @elevator.floor.to_i

      if @elevator.passengers.size > 0 then
        p_up_time = @elevator.passengers.each.inject(0){|sum, x| if not x.dest.eql?(nil) then if x.dest > f then sum + (x.dest-f) end else sum + 1 end}
        p_down_time = @elevator.passengers.each.inject(0){|sum, x| if not x.dest.eql?(nil) then if x.dest < f then sum + (x.dest-f) end else sum + 1 end}
      end



      if @elevator.callers.size > 0 then
        c_up_time = @elevator.callers.each.inject(0){|sum, x| if not x.origin.eql?(nil) then if x.origin > f then sum + (x.origin-f) end else sum + 1 end}
        c_down_time  = @elevator.callers.each.inject(0){|sum, x| if not x.origin.eql?(nil) then if x.origin > f then sum + (x.origin-f)end else sum + 1 end}
      end


      if c_up_time.eql?(nil) then c_up_time = 1 end
      if c_down_time.eql?(nil) then c_down_time = 1 end
      if p_up_time.eql?(nil) then p_up_time = 1 end
      if p_down_time.eql?(nil) then p_down_time = 1 end

      up_time = c_up_time + p_up_time
      down_time = c_down_time + p_down_time

      if up_time < down_time and not @elevator.floor.eql?(@elevator.max_floor) then @elevator.go_up
        elsif up_time > down_time and not @elevator.floor.eql?(@elevator.min_floor) then @elevator.go_down
        else @elevator.go_up
        end

      puts " time up #{up_time} down time #{down_time} floor #{@elevator.floor}"
    end




  end
end


