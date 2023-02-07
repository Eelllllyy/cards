# frozen_string_literal: true

module Api
  class BaseController < ApplicationController
    include JWTSessions::RailsAuthorization

    before_action :authorize_access_request!
    skip_before_action :verify_authenticity_token

    rescue_from JWTSessions::Errors::Unauthorized, with: :not_authorized

    private

    def not_authorized
      head :unauthorized
    end

    def current_user
      @current_user ||= ::User.find(payload['user_id'])
    end
  end
end
