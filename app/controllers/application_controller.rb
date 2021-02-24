class ApplicationController < ActionController::API
    include JWTsessions::RailsAuthorization
    rescue_from JWTsessions::Errors::Unauthorized, with :not_authorized

    private

    def current_user
        @current_user ||= User.find(payload['user_id'])
    end
    
    def not_authorized
        render json: {error: 'Not authorized'}, status: :unauthorized 
    end
end
