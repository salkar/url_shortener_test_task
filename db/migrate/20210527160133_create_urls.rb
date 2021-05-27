# frozen_string_literal: true

class CreateUrls < ActiveRecord::Migration[6.1]
  def change
    create_table :urls, id: false do |t|
      t.text :slug, primary_key: true
      t.text :url, null: false
      t.integer :open_count, default: 0, null: false
    end
  end
end
