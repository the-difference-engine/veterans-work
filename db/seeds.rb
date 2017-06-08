10.times do
  Company.create(
    email: Faker::Internet.email,
    name: Faker::Company.name,
    zip_code: Faker::Address.zip,
    phone: Faker::PhoneNumber.cell_phone,
    description: Faker::Lorem.paragraph,
    url: Faker::Internet.url,
    password: 'password'
    )
end
@service_categories = ["Paint", "Plumbing", "Carpentry", "Mechanical", "Electrical"]

@service_categories.each do |service_category|
  ServiceCategory.create(name: service_category)
end
