class CompaniesController < ApplicationController

  def index
    @companies = Company.all
    render 'index.html.erb'
  end

  def show
    @company = Company.find_by(id: params[:id])
    render 'show.html.erb'
  end

  def edit
    @company = Company.find_by(id: params[:id])
    render 'edit.html.erb'
  end

  def update
    company = Company.find(params[:id])
    company.update(company_params)
    redirect_to "/companies/#{company.id}"
  end

  def destroy
    company = Company.find(params[:id])
    company.destroy
    redirect_to 'index.html.erb'
  end

  private

  def company_params
    params.permit(
      :email,
      :password,
      :name,
      :zip_code,
      :phone,
      :description,
      :url
    )
  end

end
