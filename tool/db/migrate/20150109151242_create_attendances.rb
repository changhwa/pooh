class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.references :entry, index: true
      t.integer :number
      t.string :join_yn

      t.timestamps null: false
    end
    add_foreign_key :attendances, :entries
  end
end
