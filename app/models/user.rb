# frozen_string_literal: true

class User < ApplicationRecord
  has_one_attached :image_one
  has_one_attached :image_two

  validates :code, :tg_id, uniqueness: true
end
