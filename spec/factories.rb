require 'factory_girl'

Factory.define :user do |u|
  u.email 'test@letmesingnow.com'
  u.password 'testpw'
end

