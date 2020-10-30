# frozen_string_literal: true

class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories, id: :uuid do |t|
      t.string :name, null: false, limit: 30
      t.string :ancestry

      t.timestamps
    end
  end
end
