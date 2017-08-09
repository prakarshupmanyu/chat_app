class CreateLogins < ActiveRecord::Migration[5.1]
  
  def up
    create_table :logins do |t|
      t.integer "client_id", :null => false
      t.string "username", :null => false
      t.string "password", :null => false
      t.datetime "last_login", :null => false, :default => Time.now
      t.timestamps
    end
  end

  def down
  	drop_table :logins
  end
  
end
