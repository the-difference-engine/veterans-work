class MessageMailer < ApplicationMailer
  default from: 'noreply@veteranswork.com'

  def new_message(conversation)
    @conversation = conversation
    @customer_email_address = @conversation.customer.email
    @company_email_address = @conversation.company.email
    mail(to: @customer_email_address, subject: 'New Message - Veterans Work', body: "To see your message, visit the conversation page /conversations/#{@conversation.id}")
    mail(to: @company_email_address, subject: 'New Message - Veterans Work', body: "To see your message, visit the conversation page /conversations/#{@conversation.id}")
  end
end
