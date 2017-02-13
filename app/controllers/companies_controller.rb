
class CompaniesController < ApplicationController
  def index
    @companies = Company.all
    @attributes = Company.column_names
    render 'index.html.erb'
  end

  def new
  end

  def create
  end

  def show
    @company = Company.find_by(params[:id])
    render 'show.html.erb'
  end

  def edit
  end

  def update
    company = Company.find(params[:id])
    company.update(company_params)
  end

  def destroy
  end

  private

  def company_params
    require(:company).permit()
  end
end
