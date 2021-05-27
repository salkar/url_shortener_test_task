# frozen_string_literal: true

class Urls::Create < ApplicationService
  DIGIT_MAP =
    "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_-"
      .chars.freeze
  attr_accessor :url
  attr_reader :url_object, :success

  validates :url, presence: true

  def perform
    @url_object = Url.create(slug: slug, url: url)
    @success = true if @url_object.persisted?
  end

  def errors
    url_object&.errors.presence || super
  end

  private

    def to_s_64(num)
      raise "Only positive num allowed: #{num}" unless num.positive?
      result = ""
      while num != 0 do
        result = DIGIT_MAP[(num & 63)] + result
        num = num >> 6
      end
      result
    end

    def slug
      to_s_64(
        ActiveRecord::Base.connection.execute(
          "SELECT nextval('url_id_base_sequence') as id_base;"
        )[0]["id_base"]
      )
    end
    memoize :slug
end
