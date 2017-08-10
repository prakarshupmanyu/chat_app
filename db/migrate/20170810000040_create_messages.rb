class CreateMessages < ActiveRecord::Migration[5.1]
  
  def up
    create_table :messages do |t|
      t.integer "chat_id", :null => false
      t.integer "sender", :null => false
      t.integer "receiver", :null => false
      t.text "message", :null => false
      t.timestamps
    end
    add_index("messages", "chat_id")
  end

  def down
  	drop_table :messages
  end

end
