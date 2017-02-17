10.times do
  Company.create(
    email: Faker::Internet.email,
    name: Faker::Company.name,
    zip_code: Faker::Address.zip,
    phone: Faker::PhoneNumber.cell_phone,
    description: Faker::Lorem.paragraph,
    url: Faker::Internet.url,
    password: Faker::Cat.name
    )
end
