# frozen_string_literal: true

class AdduserIdToAlbum < ActiveRecord::Migration[6.1]
  def change
    add_column :albums, :user_id, :integer
  end
end
