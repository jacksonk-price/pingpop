require '../db_setup'
class RenameMembersTable < ActiveRecord::Migration[7.0]
  def change
    rename_table :members, :users
  end
end