class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.string :author
      t.string :doc_url
      t.references :entry, index: true

      t.timestamps null: false
    end
    add_foreign_key :articles, :entries
  end
end
