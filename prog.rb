e = []
a = []
File.readlines('input') do |line|
f = line.chomp
puts "this is #{f}"
  a.push(f)
end

a.delete_at(0)
a.each do |line|
f = line.chomp
person = Person.new(f[0].to_f, f[1].to_f, f[2].to_f, f[3].to_f)
e.push(person)
  end