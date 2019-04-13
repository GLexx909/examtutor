class CreateCharacteristics < ActiveRecord::Migration[5.2]
  def change
    create_table :characteristics do |t|
      t.references :user, foreign_key: { to_table: :users }
      t.integer :points, default: 0
      t.text :description
      t.string :rank, default: 'рядовой'

      t.timestamps
    end
  end
end
