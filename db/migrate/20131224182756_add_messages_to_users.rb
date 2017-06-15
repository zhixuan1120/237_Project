class AddMessagesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :hangout, :string
    add_column :users, :love, :string
    add_column :users, :miss, :string
    add_column :users, :apologize, :string
    add_column :users, :breakup, :string
  end
end
