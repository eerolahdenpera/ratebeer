class CreateUsers < ActiveRecord::Migration
  def new
    create_table :users do |t|
      t.string :username

      t.timestamps
    end
  end
  def change
    create_table :users do |t|
      t.string :username

      t.timestamps
    end
  end
end
