class RemoveActiveFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :active, :boolean
  end
end
