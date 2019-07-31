# require('dotenv').config()

class ApplicationController < ActionController::Base
    before_action :authenticate_request
    attr_reader :current_user

    #cant use session :( so needed to make this variable
    $logged_in = false

    private

    def authenticate_request
        @current_user = AuthorizeApiRequest.call(request.headers).result
        render json: { error: 'Not Authorized' }, status: 401 unless @current_user
    end
end
