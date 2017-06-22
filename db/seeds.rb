Admin.create!([
  {email: "admin@gmail.com", password: 'password'}
])
Customer.create!([
  {email: "customer@gmail.com", password: 'password', confirmed_at: Date.today()}
])
Company.create!([
  {email: "company@gmail.com", password: 'password', name: 'company1', address: "301 N Michigan Ave", city: "Chicago", state: "IL", zip_code: "60601", service_radius: 30.0, status: 'Active', confirmed_at: Date.today()},
  {email: "company2@gmail.com", password: 'password', name: 'company2', address: "2000 N Western Ave", city: "Chicago", state: "IL", zip_code: "60625", service_radius: 30.0, status: 'Active', confirmed_at: Date.today()},
  {email: "company3@gmail.com", password: 'password', name: 'company3', address: "2600 Lawrence ave", city: "Chicago", state: "IL", zip_code: "60625", service_radius: 30.0}
])
ServiceCategory.create!([
  {name: "Paint"},
  {name: "Plumbing"},
  {name: "Carpentry"},
  {name: "Mechanical"},
  {name: "Electrical"}
])
CompanyService.create!([
  {company_id: 1, service_category_id: 1},
  {company_id: 1, service_category_id: 2},
  {company_id: 1, service_category_id: 3},
  {company_id: 1, service_category_id: 4},
  {company_id: 1, service_category_id: 5},
  {company_id: 2, service_category_id: 2},
  {company_id: 2, service_category_id: 1},
  {company_id: 2, service_category_id: 2},
  {company_id: 2, service_category_id: 3},
  {company_id: 2, service_category_id: 4},
  {company_id: 2, service_category_id: 5},
  {company_id: 3, service_category_id: 1},
  {company_id: 3, service_category_id: 2},
  {company_id: 3, service_category_id: 3},
  {company_id: 3, service_category_id: 4},
  {company_id: 3, service_category_id: 5},
])
CustomerRequest.create!([
  {address: "4800 N Washtenaw", city: "Chicago", state: "IL", zipcode: "60625", service_category_id: 1, description: "I need a TV mounted in my living room.", customer_id: 1, expires_date: "2021-12-31"}
])
Quote.create!([
  {customer_request_id: 1, company_id: 1, materials_cost_estimate: "122.0", labor_cost_estimate: "123.0", start_date: "2017-12-28", completion_date_estimate: "2017-12-31", notes: "asdfasdfsalkdflksd", accepted: nil, customer_viewed: false}
])
