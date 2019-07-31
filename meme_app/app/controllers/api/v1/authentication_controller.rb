class Api::V1::AuthenticationController < ApplicationController
    skip_before_action :authenticate_request

    def authenticate
        command = AuthenticateUser.call(params[:user][:email], params[:user][:pass])
        if command.success?
            $logged_in ||= true;        
            render json: { token: command.result[:token], u_id: command.result[:user_info].id }
        else
            render json: { error: command.errors }, status: :unauthorized
        end
    end

    def verify_auth
        render json: { authenticated: $logged_in }
    end

end