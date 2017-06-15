class AddSenderEmailToMicroposts < ActiveRecord::Migration
  def change
  	add_column :microposts, :sender_email, :string
  end
end
