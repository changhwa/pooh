class AddNameToEntry < ActiveRecord::Migration
  def change
    add_column :entries, :name, :string
  end
end
