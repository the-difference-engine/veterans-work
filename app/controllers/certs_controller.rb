class CertsController < ApplicationController
  def show
    render 'ssl_cert.text.erb', layout: false, content_type: 'text/plain'
  end
end
