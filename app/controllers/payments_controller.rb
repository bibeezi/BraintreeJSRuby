class PaymentsController < ApplicationController  
  def checkout
    # pass client_token to your front-end
    @client_token = @gateway.client_token.generate(
      # :customer_id => a_customer_id
    )
  end

  def nonce
    # nonce from post request
    nonce_from_the_client = params[:payment_method_nonce]
    device_data = params[:device_data]

    # create transaction with payment information
    result = @gateway.transaction.sale(
      :amount => "10.00",
      :payment_method_nonce => nonce_from_the_client,
      :device_data => device_data,
      :options => {
        :submit_for_settlement => true
      }
    )

    # set up json response
    response = {:success => result.success?}

    # error handling
    if result.success?
      puts "success!: #{result.transaction.id}"
    elsif result.transaction
      puts "Error processing transaction:"
      puts "  code: #{result.transaction.processor_response_code}"
      puts "  text: #{result.transaction.processor_response_text}"
      response[:error] = result.transaction.processor_response_text
    else
      p result.errors
      response[:error] = result.errors.inspect
    end
  
    # save response in json
    render :json => response
  end
end
