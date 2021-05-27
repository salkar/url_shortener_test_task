# frozen_string_literal: true

class Urls::StatsController < ApplicationController
  before_action :find_url

  def index; end

  private

    def find_url
      @url = Url.find(params[:url_id])
    end
end
