class CreatePages < ActiveRecord::Migration
  def up
    create_table :pages do |t|
    	t.integer "subject_id"
    	#t.references :subjects
    	t.string "name", :limit => 100, :null => false
    	t.integer "permalink", :null => false
    	t.integer "position", :null => false
    	t.boolean "visible", :default => false
      	
      	t.timestamps null: false
    end

    add_index("pages", "subject_id")
  end

  def down 
  	drop_table("pages")	
  end

end
