class CreateChapters < ActiveRecord::Migration[8.0]
  def change
    create_table :chapters do |t|
      t.integer :position
      t.string :title
      t.references :book, null: true, foreign_key: true
      t.string :slug

      t.timestamps
    end
  end
end
