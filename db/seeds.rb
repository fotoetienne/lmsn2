# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts 'SETTING UP INITIAL USERS'

user = User.create :email => 'alex@letmesingnow.com', :password => 'alex', :password_confirmation => 'alex', :role => 'admin'
puts 'New user created: ' << user.name

user = User.create :email => 'stephen@letmesingnow.com', :password => 'lmsn', :password_confirmation => 'lmsn', :role => 'admin'
puts 'New user created: ' << user.name

user = User.create(:email => 'sampledj1@letmesingnow.com', :password => 'sampledj1', :password_confirmation => 'sampledj1', :role => 'dj')
user.create_dj(:name => 'Sample Dj 1')
user.dj.songs.create(:artist => 'artist1', :title => 'title1')
puts 'New user created: ' << user.name
