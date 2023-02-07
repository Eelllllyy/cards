# frozen_string_literal: true

module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private

    def find_verified_user
      if JWTSessions::Session.new.session_exists?(cookies[:token], 'access')
        token = JWTSessions::Token.decode(cookies[:token], {}).first
        @user = User.find(token['user_id'])
      else
        reject_unauthorized_connection
      end
    end
  end
end
