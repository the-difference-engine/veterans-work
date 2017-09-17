class OrdersController < ApplicationController
  def index
    if current_company
      @orders = current_company.orders
    elsif current_admin
      @orders = Order.all
    end
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      assign_credits_to_company(@order)
      flash[:success] = 'Your order has been successfully processed.'
      redirect_to "/orders/#{@order.id}"
    else
      flash[:danger] = 'Something went wrong please submit again.'
      render :new
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  def edit
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      flash[:success] = 'Your order has been successfully updated.'
      redirect_to "/orders/#{@order.id}"
    else
      flash[:danger] = 'Something went wrong please submit again.'
      render :edit
    end
  end

  def destroy
    Order.find(params[:id]).destroy
    redirect_to '/orders'
  end

  private

  def order_params
    params.require(:order).permit(
      :quantity
    ).merge(company_id: current_company.id)
  end

  def assign_credits_to_company(order)
    order.company.increment!(:credits, order.quantity)
  end
end
