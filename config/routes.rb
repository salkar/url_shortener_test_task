# frozen_string_literal: true

Rails.application.routes.draw do
  defaults format: :json do
    resources :urls, only: %i[create show] do
      scope module: "urls" do
        resources :stats, only: :index
      end
    end
  end
end
