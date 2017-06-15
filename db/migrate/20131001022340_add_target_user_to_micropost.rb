class AddTargetUserToMicropost < ActiveRecord::Migration
  def change
  	add_column :microposts, :target, :string
  end
end
