# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

['Customer', 'SalesRep', 'Technician'].each do |role_name|
  Role.find_or_create_by!(name: role_name)
end

OptionType::DEFAULT_TYPES.each do |option_type|
  OptionType.find_or_create_by!(name: option_type)
end
