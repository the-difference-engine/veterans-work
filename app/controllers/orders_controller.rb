class OrdersController < ApplicationController
  before_action :authenticate_company!, only: [:create]



  def index
    if current_company
      @orders = current_company.orders
    elsif current_admin
      @orders = Order.all
    else
      redirect_to '/'
    end
  end

  def new
    redirect_to '/customer_requests'
  end

  def create
    order = Order.new(
              company_id: params['companyId'],
              quantity: params['quantity'].to_i,
              total: params['total'].to_d
              )


    if order.save
      assign_credits_to_company(order)
    else
      raise 'test error'
    end
  end

  def show
    order = Order.find(params[:id])
    if order.company == current_company
      @order = order
    else
      redirect_to '/'
    end
  end

  private

  def assign_credits_to_company(order)
    order.company.increment!(:credits, order.quantity)
  end

end
