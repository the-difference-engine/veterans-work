
class PaypalController < ApplicationController
# :nocov:
  skip_before_action :verify_authenticity_token

  def get_access_token
    HTTParty.post(
      'https://api.sandbox.paypal.com/v1/oauth2/token',
      {
        headers: {'Content-Type' => 'application/x-www-form-urlencoded'},
        basic_auth: {
          username: ENV['PAYPAL_CLIENT_ID'],
          password: ENV['PAYPAL_SECRET']
        },
        body: { 'grant_type' => 'client_credentials' }
      }
    )
  end

  def create_payment
    access_token = get_access_token.parsed_response['access_token']
    p get_access_token.parsed_response
    response = HTTParty.post('https://api.sandbox.paypal.com/v1/payments/payment',
      headers: {
        'Accept' => 'application/json',
        'Authorization' => "Bearer #{access_token}"
      },
      body: {
        'intent' => 'sale',
        'experience_profile_id' => 'experience_profile_id',
        'redirect_urls' => {
          'return_url' => 'http://<return URL>',
          'cancel_url' => 'http://<cancel URL>'
        },
        'payer' => {
          'payment_method' => 'paypal'
        },
        'transactions' => [{
          'amount' => {
            'total' => '4.00',
            'currency' => 'USD',
            'details' => {
              'subtotal' => '2.00',
              'shipping' => '1.00',
              'tax' => '2.00',
              'shipping_discount' => '-1.00'
            }
          },
          'item_list' => {
            'items' => [{
              'quantity' => '1',
              'name' => 'item 1',
              'price' => '1',
              'currency' => 'USD',
              'description' => 'item 1 description',
              'tax' => '1'
            },
            {
              'quantity' => '1',
              'name' => 'item 2',
              'price' => '1',
              'currency' => 'USD',
              'description' => 'item 2 description',
              'tax' => '1'
            }]
          },
          'description' => 'The payment transaction description.',
          'invoice_number' => 'merchant invoice',
          'custom' => 'merchant custom data'
        }]
      }
    )
    p response
    render json: response
  end
# :nocov:
end

