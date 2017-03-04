class RemoveFieldStyleFromBeer < ActiveRecord::Migration
  def change
    remove_column :beers, :style, :string
  end
end
