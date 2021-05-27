# frozen_string_literal: true

class AddUrlIdBaseSequence < ActiveRecord::Migration[6.1]
  def up
    execute <<-SQL.squish
      CREATE SEQUENCE url_id_base_sequence;
    SQL
  end

  def down
    execute <<-SQL.squish
      DROP SEQUENCE url_id_base_sequence;
    SQL
  end
end
