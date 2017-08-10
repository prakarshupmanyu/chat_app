class CreateChats < ActiveRecord::Migration[5.1]
  
  def up
    create_table :chats do |t|
      t.integer "client1", :null => false
      t.integer "client2", :null => false
      t.integer "num_messages", :default => 0, :null => false
      t.timestamps
    end
    add_index("chats", "client2")
    add_index("chats", "client1")
  end

  def down
  	drop_table :chats
  end

end
