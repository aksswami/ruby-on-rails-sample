class CreateSubjects < ActiveRecord::Migration
  def up
    create_table :subjects do |t|
    	t.string "name", :limit => 100, :null => false
    	t.integer "position", :null => false
    	t.boolean "visible", :default => false

      	t.timestamps null: false
    end
  end

  def down
   drop_table :subjects
  end

end
