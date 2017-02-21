namespace :cron_tasks do
  desc "archiving old requests"
  task :send_data => :environment do
    expired_requests = CustomerRequest.where("expires_date < ?", Date.today() + 1)
    expired_requests.each do |request|
      if ExpiredCustomerRequest.create(request)
        request.destroy_all
      end
    endf
  end
end
