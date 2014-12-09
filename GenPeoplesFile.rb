# GenPeopleFiles.rb
# Generates input files and file sequences for an
#   elevator simulation.
# M. Laszlo
# November 2014

module GenPeopleFiles
  module ModMethods
    # generate an input file for elevator simulation
    #   filename: written to this file
    #   nbr_floors: floors range from 1 through nbr_floors
    #   rate: average number of arrivals (events) per time unit
    #   max_time: time units 1, 2, ..., max_time
    # file format:
    # <nbr_floors>
    # <id>1 <arrival_time>1 <origin_floor>1 <destination_floor>1
    # ...
    # <id>n <arrival_time>n <origin_floor>n <destination_floor>n
    def gen_input_file(filename, nbr_floors, rate, max_time)
      File.open(filename, 'w') do |f|
        time = 1
        indx = 99
        f.puts(nbr_floors)
        loop do
          time += sleep_for(rate)
          break if time >= max_time+1
          indx += 1
          org = rand_in_range(1, nbr_floors+1)
          dest = rand_in_range(1, nbr_floors)
          dest += 1 if dest >= org
          res = [indx, time.to_i, org, dest]
          res = res.map(&:to_s).join(' ')
          f.puts(res)
        end
      end
    end

    # generate a series of elevator simulation files
    def gen_input_files(fileprefix, nbr_files, nbr_floors, rate, max_time)
      nbr_files.times do |n|
        filename = fileprefix + ("%.3d" % n) + '.in'
        gen_input_file(filename, nbr_floors, rate, max_time)
      end
    end

    # Poisson process rate: Average number of events per time unit
    def sleep_for(rate)
      -Math.log(1.0 - Random.rand) / rate
    end

    def rand_in_range(a, b)
      rand(b-a) + a
    end
  end

  extend ModMethods
end