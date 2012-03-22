class CreateMicroposts < ActiveRecord::Migration
  def change
    create_table :microposts do |t|
      t.string :content
      t.integer :user_id

      t.timestamps
    end
    add_index :microposts, [:user_id, :created_at]
    #By including both the user_id and created_at columns as an array, we arrange for Rails to 
    #create a multiple key index, which means that Active Record uses both keys at the same time. 
  end
end
