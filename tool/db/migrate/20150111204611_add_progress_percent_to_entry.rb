class AddProgressPercentToEntry < ActiveRecord::Migration
  def change
    add_column :entries, :progress_percent, :integer
  end
end
