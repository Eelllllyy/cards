# frozen_string_literal: true

module Api
  class WebhooksController < BaseController
    skip_before_action :authorize_access_request!, only: :update

    def update
      return head :unprocessable_entity unless params[:token] == ENV.fetch('WEBHOOK_TOKEN')

      user = User.find_by(tg_id: params[:tg_id])
      return head :not_found unless user

      UserChannel.broadcast_to('users', { user_id: user.id, passed: true }) if user.update(passed: true)
      head :ok
    end
  end
end
