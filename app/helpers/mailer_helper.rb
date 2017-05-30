module MailerHelper
  def welcome_mailer_params
    from = Email.new(email: 'noreply@veteranswork.com')
    subject = 'Hello World from the SendGrid Ruby Library'
    to = Email.new(email: 'veteransworkheroku@gmail.com')
    content = Content.new(type: 'text/plain', value: 'Welcome to Veterans Work! Your account will be evaluated before being activated!')
    mail = Mail.new(from, subject, to, content)
    puts JSON.pretty_generate(mail.to_json)
    # puts mail.to_json

    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'], host: 'https://api.sendgrid.com')
    response = sg.client.mail._('send').post(request_body: mail.to_json)
    puts response.status_code
    puts response.body
    puts response.headers
  end
end