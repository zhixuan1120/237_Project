class AddEmailToMicropost < ActiveRecord::Migration
  def change
  	add_column :microposts, :email, :string
  end
end
