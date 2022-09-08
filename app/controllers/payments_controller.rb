class PaymentsController < ApplicationController  
  def checkout
    # pass client_token to your front-end
    @client_token = @gateway.client_token.generate(
      # :customer_id => a_customer_id
    )
  end

  def subscription
    # create subscription with payment information
    result = @gateway.subscription.create(
      :payment_method_token => "token"
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
