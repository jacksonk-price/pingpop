require '../db_setup'
class ChangeIntegerLimitUsers < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :discord_id, :integer, limit: 8
  end
end