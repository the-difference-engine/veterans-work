class CustomerRequestsController < ApplicationController
  before_action :authenticate_customer!, only: [:create, :new], unless: :current_admin_user
  before_action :validate_customer_request!, only: [:show, :edit, :update, :destroy]

  def index
    if current_customer
      @requests = current_customer.customer_requests.where(
        "expires_date >= ?",
        10.days.ago
      )
      @customer = current_customer
      render "index.html.erb"
    elsif current_company
      if current_company.status == "Active"
        @requests = current_company.eligible_customer_requests
        @company = current_company
        render "index.html.erb"
      elsif current_company.status == "Pending"
        flash[:notice] = "Thank you for registering! Your company is currently under review."
        redirect_to "/companies/#{current_company.id}"
      end
    else
      redirect_to "/"
    end
  end

  def new
    @customer_request = CustomerRequest.new
    @categories = ServiceCategory.all
    render "new.html.erb"
  end

  def create
    @request = CustomerRequest.new(customer_request_params)
    @request.save
    flash[:success] = "You did it!"
    redirect_to "/customers/#{current_customer.id}"
  end

  def show
    @request = CustomerRequest.find(params[:id])
    render "show.html.erb"
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def customer_request_params
    params.require(:customer_request).permit(
      :address,
      :city,
      :state,
      :zipcode,
      :description,
      :expires_date,
      :service_category_id
    ).merge(customer_id: current_customer.id)
  end

  def validate_customer_request!
    @customer_request = CustomerRequest.find(params[:id])
    unless @customer_request.customer == current_customer || (
        current_company.eligible_customer_requests.include?(
          @customer_request
        ) if current_company
      ) || current_admin
      redirect_to '/', notice: 'insufficient privileges'
    end
  end

  def current_admin_user
    current_admin ? true : false
  end
end
