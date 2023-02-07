# frozen_string_literal: true

module Api
  class UsersController < BaseController
    def index
      users = User.order(:number)
      render json: UserSerializer.render(users, view: :index)
    end
  end
end
