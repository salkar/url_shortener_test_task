# frozen_string_literal: true

# ## Schema Information
#
# Table name: `urls`
#
# ### Columns
#
# Name              | Type               | Attributes
# ----------------- | ------------------ | ---------------------------
# **`open_count`**  | `integer`          | `default(0), not null`
# **`slug`**        | `text`             | `not null, primary key`
# **`url`**         | `text`             | `not null`
#
FactoryBot.define do
  factory :url do
    sequence(:slug) { |n| "some_slug_#{n}" }
    url { Faker::Internet.url }
  end
end
