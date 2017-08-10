class CreateClients < ActiveRecord::Migration[5.1]
  
  def up
    create_table :clients do |t|
      t.string "first_name", :null => false, :limit => 40
      t.string "last_name", :null => false, :limit => 40
      t.string "username", :null => false, :limit => 25
      #t.string "password", :null => false
      t.string "password_digest", :null => false
      t.integer "age", :null => false
      t.string "email", :null => false, :limit => 100
      t.string "client_type" 
      t.date "date_of_birth"
      t.timestamps
    end
    add_index("clients", "username")
    add_index("clients", "password_digest")
    add_index("clients", "email") #for Forget Password functionality. Won't be implementing it though
  end

  def down
  	drop_table :clients
  end

end
