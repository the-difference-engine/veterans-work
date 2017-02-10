class CompaniesController < ApplicationController
  def index
    companies = Company.all
  end

  def new
  end

  def create
  end

  def show
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
