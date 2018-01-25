admin = Admin.create!({email: "admin@gmail.com", password: 'password'})

customer = Customer.create!({email: "customer@gmail.com", password: 'password', confirmed_at: Date.today()})

company1 = Company.create!({email: "company@gmail.com", password: 'password', name: 'company1', address: "301 N Michigan Ave", city: "Chicago", state: "IL", zip_code: "60601", service_radius: 30.0, description: 'hello there handy service', phone: '3123231234', url: 'http://localhost:3000/customer_requests', status: 'Active', confirmed_at: Date.today()})
company2 = Company.create!({email: "company2@gmail.com", password: 'password', name: 'company2', address: "2000 N Western Ave", city: "Chicago", state: "IL", zip_code: "60625", service_radius: 30.0, description: 'hello there handy service', phone: '3123231234', url: 'http://localhost:3000/customer_requests', status: 'Active', confirmed_at: Date.today()})
company3 = Company.create!({email: "company3@gmail.com", password: 'password', name: 'company3', address: "2600 Lawrence ave", city: "Chicago", state: "IL", zip_code: "60625", service_radius: 30.0, description: 'hello there handy service', phone: '3123231234', url: 'http://localhost:3000/customer_requests'})

service1 = ServiceCategory.create!({name: "Paint"})
service2 = ServiceCategory.create!({name: "Plumbing"})
service3 = ServiceCategory.create!({name: "Carpentry"})
service4 = ServiceCategory.create!({name: "Mechanical"})
service5 = ServiceCategory.create!({name: "Electrical"})

CompanyService.create!([
  {company_id: company1.id, service_category_id: service1.id},
  {company_id: company1.id, service_category_id: service2.id},
  {company_id: company1.id, service_category_id: service3.id},
  {company_id: company1.id, service_category_id: service4.id},
  {company_id: company1.id, service_category_id: service5.id},
  {company_id: company2.id, service_category_id: service2.id},
  {company_id: company2.id, service_category_id: service1.id},
  {company_id: company2.id, service_category_id: service2.id},
  {company_id: company2.id, service_category_id: service3.id},
  {company_id: company2.id, service_category_id: service4.id},
  {company_id: company2.id, service_category_id: service5.id},
  {company_id: company3.id, service_category_id: service1.id},
  {company_id: company3.id, service_category_id: service2.id},
  {company_id: company3.id, service_category_id: service3.id},
  {company_id: company3.id, service_category_id: service4.id},
  {company_id: company3.id, service_category_id: service5.id},
])

customer_request = CustomerRequest.create!({address: "4800 N Washtenaw", city: "Chicago", state: "IL", zipcode: "60625", service_category_id: service1.id, description: "I need a TV mounted in my living room.", customer_id: customer.id, expires_date: "2021-12-31"})

Quote.create!([
  {
    customer_request_id: customer_request.id,
    company_id: company1.id,
    materials_cost_estimate: "122.0",
    labor_cost_estimate: "123.0",
    start_date: "2017-12-28",
    completion_date_estimate: "2017-12-31",
    notes: "asdfasdfsalkdflksd",
    accepted: nil,
    customer_viewed: false
  }
])
