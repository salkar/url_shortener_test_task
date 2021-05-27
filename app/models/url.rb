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
class Url < ApplicationRecord
  self.primary_key = "slug"

  validates :open_count, presence: true
  validates :slug, presence: true
  validates :url, presence: true
end
