# frozen_string_literal: true

if @service.success
  json.set! :data do
    json.short_url url_url(@service.url_object.slug)
  end
else
  json.set! :errors, @service.errors.details
end
