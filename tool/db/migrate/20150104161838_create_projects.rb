class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.text :description

      t.timestamps null: false
    end
    add_index :projects, :title, unique: true
  end
end
