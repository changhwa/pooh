class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :passwd
      t.string :name
      t.string :nick
      t.integer :grade
      t.string :permisson

      t.timestamps null: false
    end
    add_index :users, :email, unique: true
    add_index :users, :nick, unique: true
  end
end
