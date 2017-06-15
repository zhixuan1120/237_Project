class RemoveTagFromUser < ActiveRecord::Migration
  def change
  	remove_column :users, :hangout
  	remove_column :users, :love
  	remove_column :users, :miss
  	remove_column :users, :apologize
  	remove_column :users, :breakup
  end
end
