# frozen_string_literal: true

class FileSerializer < Blueprinter::Base
  identifier :id

  field :url do |obj|
    Rails.application.routes.url_helpers.rails_blob_url(obj)
  end
end
