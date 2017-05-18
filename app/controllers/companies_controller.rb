class CompaniesController < ApplicationController

  before_action :assign_company, only: [:show, :edit, :update, :destroy]

  def index
    if current_admin
      if params[:query]
        @companies = Company.search_by_query(params[:query]).order(params[:sortby])
      else
        @companies = Company.order(params[:sortby])
      end
      render 'index.html.erb'
    else
      redirect_to '/'
    end
  end

  def show
    company = Company.find_by(id: params[:id])
    if current_admin || current_company.id == company.id
      render 'show.html.erb'
    else
      redirect_to '/'
    end
  end

  def edit
    @company = Company.find_by(id: params[:id])
    render 'edit.html.erb'
  end

  def update
    company = Company.find(params[:id])
    if params[:status] && current_admin
      company.update(status: params[:status])
      redirect_to "/companies/#{company.id}/edit"
    elsif current_company
      current_company.update(company_params)
      redirect_to "/companies/#{company.id}"
    end
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
      :url,
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
