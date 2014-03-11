class CreatePosts < ActiveRecord::Migration
  def change
  	create_table :posts do |t|
  		t.string :entry
  	end
  end
end
