class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
  before_action :restrict_access, :except => [:index,:show,:sale]

   private

    def read_access_token(token)
      @access_token = token
      parts = token.split('--')

      if parts[1] == Rails.application.secrets.secret_key_base
      	@ApiKey = token
      else
        render json: { message: 'Wrong token' }, status: :unauthorized
      end
    end

    def crypt
      ActiveSupport::MessageEncryptor.new(Rails.application.secrets.secret_key_base)
    end

    def restrict_access
      unless restrict_access_by_header
        render json: { message: 'Invalid API Token' }, status: :unauthorized
      end
    end

    def restrict_access_by_header
      return true if @api_key

      authenticate_with_http_token do |token|
        if token.include? '--'
          read_access_token token
        else
          @api_key = ApiKey.find_by_token token
        end
      end
    end

    def restrict_access_by_params
      return true if @api_key

      @api_key = ApiKey.find_by_token(params[:token])
    end

end
