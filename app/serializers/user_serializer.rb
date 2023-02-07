# frozen_string_literal: true

class UserSerializer < BaseSerializer
  view :index do
    field :number
    field :passed
    field :image_one do |obj|
      FileSerializer.render_as_hash(obj.image_one) if obj.image_one.attached?
    end
    field :image_two do |obj|
      FileSerializer.render_as_hash(obj.image_two) if obj.image_two.attached?
    end
  end
end
