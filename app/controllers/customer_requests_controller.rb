class CustomerRequestsController < ApplicationController

  def index
    @requests = CustomerRequest.all
    @attributes = Company.column_names
    render "index.html.erb"
  end

  def new
    render "new.html.erb"
  end

  def create
    @request = CustomerRequest.new(
      name: params["name"],
      email: params["email"],
      phone: params["phone"],
      industry: params["industry"],
      job_type: params["job_type"],
      project_type: params["project_type"],
      explanation: params["explanation"],
      location: params["location"],
      customer_availability: params["customer_availability"]
      )
    @request.save
    flash[:success] = "You did it!"
    redirect_to '/requests'
  end

  def show
    render "show.html.erb"
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
