# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

3.times do
  Cat.new(
    birth_date: Faker::Date.between(20.years.ago, Date.yesterday),
    color: Cat::COLORS.sample,
    name: Faker::Internet.user_name,
    sex: Cat::SEXES.sample,
    description: Faker::Hacker.say_something_smart
  ).save!
end



CatRentalRequest.create(
  cat: Cat.find(1),
  start_date: Date.new(2014, 1, 1),
  end_date: Date.new(2014, 6, 1),
  status: "APPROVED"
)

CatRentalRequest.create(
  cat: Cat.find(1),
  start_date: Date.new(2015, 1, 1),
  end_date: Date.new(2015, 6, 1),
  status: "APPROVED"
)

CatRentalRequest.create(
  cat: Cat.find(1),
  start_date: Date.new(2016, 1, 1),
  end_date: Date.new(2016, 6, 1),
  status: "PENDING"
)

CatRentalRequest.create(
  cat: Cat.find(1),
  start_date: Date.new(2016, 3, 1),
  end_date: Date.new(2016, 7, 1),
  status: "PENDING"
)

#
#
#

CatRentalRequest.create(
  cat: Cat.find(2),
  start_date: Date.new(2016, 1, 1),
  end_date: Date.new(2016, 6, 1),
  status: "APPROVED"
)

CatRentalRequest.create(
  cat: Cat.find(2),
  start_date: Date.new(2015, 1, 1),
  end_date: Date.new(2015, 6, 1),
  status: "PENDING"
)


#
#
#
