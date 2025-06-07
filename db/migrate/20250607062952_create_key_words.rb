class CreateKeyWords < ActiveRecord::Migration[8.0]
  def change
    create_table :key_words do |t|
      t.string :word
      t.references :section, null: false, foreign_key: true
      t.string :slug

      t.timestamps
    end
  end
end
