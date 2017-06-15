class AddInformToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :inform, :boolean
  end
end
