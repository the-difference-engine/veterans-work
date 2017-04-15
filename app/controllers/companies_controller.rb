class CompaniesController < ApplicationController
  before_action :assign_company, only: [:show, :edit, :update, :destroy]

  before_action :authenticate_company!, only: [:show, :edit, :update, :destroy]

  def index
    if params[:query]
      @companies = Company.where("lower(name) LIKE ?", "%#{params[:query].downcase}%")
    else
      @companies = Company.all
    end
    render 'index.html.erb'
  end

  def show
    company = Company.find_by(id: params[:id])
    if current_company.id == company.id
      render 'show.html.erb'
    else
      redirect_to '/'
    end
  end

  def edit
    render 'edit.html.erb'
  end

  def update
    @company.update(company_params)
    redirect_to "/companies/#{@company.id}"
  end

  def destroy
    @company.destroy
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

  def assign_company
    if current_admin
      @company = Company.find(params[:id])
    elsif current_company
      @company = current_company
    else
      redirect_to "/companies/#{current_company.id}"
    end
  end

end
