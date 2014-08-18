# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# indexes = Index.create([{ name: '上证指数', }, { name: 'Copenhagen' }])
# Mayor.create(name: 'Emanuel', city: cities.first)


Index.create!(opening_price: 2222, closing_price: 2223, current_date: Date.parse('2014-08-11'))