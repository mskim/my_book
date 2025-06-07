class CreateBooks < ActiveRecord::Migration[8.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :subtitle
      t.string :slug
      t.string :author

      t.timestamps
    end
  end
end
