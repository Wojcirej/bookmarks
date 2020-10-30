class CreateLinks < ActiveRecord::Migration[6.0]
  def change
    create_table :links, id: :uuid do |t|
      t.string :name, null: false, limit: 60
      t.text :description
      t.string :url, null: false
      t.uuid :category_id, null: false

      t.timestamps
    end

    add_foreign_key :links, :categories
    add_index :links, :category_id, name: 'index_links_on_category_id'
  end
end
