# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts 'SETTING UP TEST USER LOGIN'
user = User.create! :email => 'test@letmesingnow.com', :password => 'testpw', :password_confirmation => 'testpw'
puts 'New user created: ' << user.email
