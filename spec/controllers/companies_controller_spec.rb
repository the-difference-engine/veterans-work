require 'rails_helper'

RSpec.describe CompaniesController, type: :controller do
 describe 'GET #index' do
   xit 'assigns all the companies to @companies' do
     all_companies = [
       create(:company),
       create(:company),
       create(:company),
     ]
     get :index
     expect(assigns(:companies)).to eq(all_companies)
   end

   xit "renders the index template" do
     get :index
     expect(response).to render_template("index.html.erb")
   end
 end

 describe 'GET #show' do
   xit 'renders show page' do
     get(:show, id: 1)
     expect(response).to render_template("show.html.erb")
   end
 end

 describe 'GET #edit' do
   xit 'renders edit page' do
     get(:edit, id: 5)
     expect(response).to render_template("edit.html.erb")
   end
 end

 describe 'PATCH #update' do
   it 'update the values of the company' do
     company = create(:company,
       name: "old value",
       phone: "1234"
     )
     patch :update, params: { id: company.id }

     company.reload
     expect(company.name).to eq("New Value")
     expect(company.phone).to eq("5678")
   end
   xit 'redirect to the company page' do
     company = create(:company)
     patch(:update, id: company.id)
     expect(response).to redirect_to("/companies/#{assigns(:company).id}")
   end
 end
end
