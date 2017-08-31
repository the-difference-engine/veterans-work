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
    if current_admin || current_company || current_customer
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
      :avatar,
    )
  end

  def assign_company
    company = Company.find(params[:id])
    if current_admin
      @company = company
    elsif current_company
      @company = current_company
    elsif current_customer
      if (current_customer.contracts & company.contracts).any?
        @company = company
        @readaction_boolean = false
      elsif (current_customer.quotes.map(&:id) & company.quotes.map(&:id)).any?
        @company = company
        @readaction_boolean = true
      else
        redirect_to "/"
      end
    else
      redirect_to "/"
    end
  end

  # private

  # def company_image
  #   params.require(:company).permit(:avatar)
  # end

end

