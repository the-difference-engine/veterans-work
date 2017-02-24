
class CompaniesController < ApplicationController
  def index
    @companies = Company.all
    @attributes = Company.column_names
    render 'index.html.erb'
  end

  def show
    @company = Company.find_by(id: params[:id])
    render 'show.html.erb'
  end

  def edit
    render 'edit.html.erb'
  end

  def update
    company = Company.find(params[:id])
    company.update(company_params)
    redirect_to "/companies/#{company.id}"
  end

  def show_services
    @service_categories = ServiceCategory.all
  end

  def update_services
    @service_categories = ServiceCategory.all
    params['service_category'].each do |service_category|
      CompanyService.create(
        company_id: current_company.id,
        service_category_id: service_category.to_i
      )
    end
    redirect_to "/companies/#{current_company.id}"
  end

  def destroy
    company = Company.find_by(params[:id])
    company.destroy
    redirect_to 'index.html.erb'
  end

  private

  def company_params
    require(:company).permit(
      email: params[:email],
      password: params[:password],
      name: params[:name],
      zip_code: params[:zip_code],
      phone: params[:phone],
      description: params[:description],
      url: params[:url]
    )
  end
end
