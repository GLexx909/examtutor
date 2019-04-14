class CreateTests < ActiveRecord::Migration[5.2]
  def change
    create_table :tests do |t|
      t.string :title, null: false
      t.integer :timer, null: false
      t.references :modul, foreign_key: true

      t.timestamps
    end
  end
end
