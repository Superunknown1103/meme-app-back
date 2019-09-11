class Api::V1::AuthenticationController < ApplicationController
    skip_before_action :authenticate_request, except: [:current_user]

    def authenticate
        command = AuthenticateUser.call(params[:user][:email], params[:user][:pass])
        if command.success?
            render json: { token: command.result[:token], u_id: command.result[:user_info].id.to_s, u_name: command.result[:user_info].name }, status: :ok
        else
            render json: { error: command.errors }, status: :unauthorized
        end
    end
end