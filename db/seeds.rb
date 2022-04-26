# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

teams = Team.create([
	{name: "HR"}, 
	{name: "Software Development"}, 
	{name: "Admin"}, 
	{name: "Customer Support"}, 
	{name: "Accounts"}
])

30.times do |x|
	x += 1
	Employee.create({name: "EMP#{x}", email: "emp#{x}@gd.com", password: "abcd1234", opt_in: true})
end

Employee.create({name: "Admin", email: "admin@dg.com", password: "admin123", role: 2})

groups = Employee.ids.in_groups(teams.size, false)

Team.all.each_with_index do |x, i|
	groups[i].each do |g|
		EmployeeTeam.create({employee_id: g, team_id: x.id})
	end
end