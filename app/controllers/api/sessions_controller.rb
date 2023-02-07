# frozen_string_literal: true

module Api
  class SessionsController < BaseController
    skip_before_action :authorize_access_request!, only: :create

    def show
      user = User.find(payload['user_id'])
      render json: UserSerializer.render(user)
    end

    def create
      user = User.find_by(code: params[:code])
      return head :unprocessable_entity unless user

      payload = { user_id: user.id }
      session = JWTSessions::Session.new(payload:)
      render json: session.login
    end
  end
end
