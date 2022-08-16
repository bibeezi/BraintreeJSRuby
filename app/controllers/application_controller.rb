class ApplicationController < ActionController::Base
    protect_from_forgery with: :null_session
    before_action :set_gateway

    def set_gateway
        @gateway = Braintree::Gateway.new(
            :environment => :sandbox,
            :merchant_id => "yfkk4m7p4cgstzsm",
            :public_key => "8bbmv4vf6yyjhzyr",
            :private_key => "dd385bd77cb820703570ed60608fc970",
        )
    end
end
