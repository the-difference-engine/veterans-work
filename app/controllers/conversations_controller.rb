class ConversationsController < ApplicationController

  def index
    if current_company
      @conversations = current_company.conversations
    else
      @conversations = current_customer.conversations
    end
  end

  def create
    @quote = Quote.find(params[:quote_id])
    if current_customer && @quote.customer_request.customer == current_customer
      conversation = Conversation.new(quote_id: @quote.id, company_id: @quote.company.id, customer_id: current_customer.id)
    elsif current_company && @quote.company == current_company
      conversation = Conversation.new(quote_id: @quote.id, company_id: current_company.id, customer_id: @quote.customer_request.customer.id)
    end

    if conversation && conversation.save
      redirect_to "/conversations/#{conversation.id}"
    else
      render :show 
    end
  end

  def show
    @messages = Conversation.find(params[:id]).messages.includes(:company, :customer).order('created_at')
    @conversation = Conversation.find(params[:id])

    if current_company
      @me = current_company
      @them = @conversation.customer
    else
      @me = current_customer
      @them = @conversation.company
    end

    if @messages.count == 0
      render 'show.html.erb'
    elsif @messages[0].conversation.company == current_company || @messages[0].conversation.customer == current_customer
      render 'show.html.erb'
    else
      redirect_to '/'
    end
  end

  def message
    @conversation = Conversation.find(params[:id])
    if params[:customer_id]
      @message = Message.create(body: params[:body], conversation_id: @conversation.id, customer_id: params[:customer_id])
      MessageMailer.new_message(@conversation).deliver_now
      redirect_to "/conversations/#{@conversation.id}"
    elsif params[:company_id]
      @message = Message.create(body: params[:body], conversation_id: @conversation.id, company_id: params[:company_id])
      MessageMailer.new_message(@conversation).deliver_now
      redirect_to "/conversations/#{@conversation.id}"
    else
      flash[:notice] = "You need to be signed in to create a message."
      redirect_to '/'
    end
  end


end
