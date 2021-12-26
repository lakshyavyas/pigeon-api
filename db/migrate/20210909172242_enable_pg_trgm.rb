# frozen_string_literal: true

# Create users table
class EnablePgTrgm< ActiveRecord::Migration[6.1]

  def change
    enable_extension 'pg_trgm'
    enable_extension 'btree_gist'
  end
end
