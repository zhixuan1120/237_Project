class AddReadToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :read, :boolean
  end
end
