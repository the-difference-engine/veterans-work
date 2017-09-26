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
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      process_payment
      flash[:success] = 'Your order has been successfully processed.'
      redirect_to "/orders/#{@order.id}"
    else
      flash[:danger] = 'Something went wrong please submit again.'
      render :new
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

  def order_params
    params.require(:order).permit(
      :quantity,
      :first_name,
      :last_name,
      :credit_card_number,
      :security_code,
      :exp_date

    ).merge(company_id: current_company.id)
  end

# :nocov:
  def process_payment
    gateway = ActiveMerchant::Billing::TrustCommerceGateway.new(
      login: ENV['ACTIVE_MERCHANT_LOGIN'],
      password: ENV['ACTIVE_MERCHANT_PASSWORD']
    )
    # ActiveMerchant accepts all amounts as Integer values in cents
    amount = 500 * @order.quantity

    # The card verification value is also known as CVV2, CVC2, or CID
    credit_card = ActiveMerchant::Billing::CreditCard.new(
                    :first_name         => 'Bob',
                    :last_name          => 'Bobsen',
                    :number             => '4242424242424242',
                    :month              => params[:exp_date][0..1],
                    :year               => Time.now.year+1,
                    :verification_value => '000')

    # Validating the card automatically detects the card type
    if credit_card.validate.empty?
      # Capture $10 from the credit card
      response = gateway.purchase(amount, credit_card)

      if response.success?
        assign_credits_to_company(@order)
        puts "Successfully charged $#{sprintf("%.2f", amount / 100)} to the credit card #{credit_card.display_number}"
      else
        raise StandardError, response.message
      end
    end
  end

  def assign_credits_to_company(order)
    order.company.increment!(:credits, order.quantity)
  end
# :nocov:
end
