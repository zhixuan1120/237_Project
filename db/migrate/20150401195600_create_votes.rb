class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
    	t.belongs_to :user
    	t.belongs_to :micropost
    	t.integer :value

    	t.timestamps
    end
    add_index :votes, :micropost_id
    add_index :votes, :user_id
  end
end
