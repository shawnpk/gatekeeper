# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

unless User.exists?(email: 'admin@gatekeeper.com')
  User.create(email: 'admin@gatekeeper.com', password: 'password', admin: true)
end

unless User.exists?(email: 'viewer@gatekeeper.com')
  User.create(email: 'viewer@gatekeeper.com', password: 'password')
end

['Atom.io', 'Safari'].each do |name|
  unless Project.exists?(name: name)
    Project.create(name: name, description: "A sample project about #{name}")
  end
end
