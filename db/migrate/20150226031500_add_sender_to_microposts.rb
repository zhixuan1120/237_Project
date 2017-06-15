class AddSenderToMicroposts < ActiveRecord::Migration
  def change
  	add_column :microposts, :sender_name, :string
  end
end
