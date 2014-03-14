class CreatePosts < ActiveRecord::Migration
  def change
  	create_table :posts do |t|
  		t.string :entry
  		t.integer :user_id
  	end
  end
end
