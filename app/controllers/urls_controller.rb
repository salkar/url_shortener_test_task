# frozen_string_literal: true

class UrlsController < ApplicationController
  before_action :find_url, only: :show

  def create
    @service = Urls::Create.new(url: params[:url])
    @service.perform
    render status: @service.success ? :created : :unprocessable_entity
  end

  def show
    Url.increment_counter(:open_count, @url.slug)
  end

  private

    def find_url
      @url = Url.find(params[:id])
    end
end
