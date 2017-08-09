class CreateClients < ActiveRecord::Migration[5.1]
  
  def up
    create_table :clients do |t|
      t.string "first_name", :null => false
      t.string "last_name", :null => false
      t.integer "age", :null => false
      t.string "email", :null => false
      t.string "client_type" 
      t.date "date_of_birth"
      t.timestamps
    end
  end

  def down
  	drop_table :clients
  end

end
