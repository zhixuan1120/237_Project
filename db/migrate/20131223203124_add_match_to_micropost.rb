class AddMatchToMicropost < ActiveRecord::Migration
  def change
    add_column :microposts, :match, :boolean
  end
end
