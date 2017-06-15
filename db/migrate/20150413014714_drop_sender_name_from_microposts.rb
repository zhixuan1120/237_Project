class DropSenderNameFromMicroposts < ActiveRecord::Migration
  def change
  	remove_column :microposts, :sender_name
  end
end
