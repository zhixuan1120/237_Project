class RemoveTargetFromMicropost < ActiveRecord::Migration
  def change
  	remove_column :microposts, :target
  end
end
