class CreateProgresses < ActiveRecord::Migration[5.2]
  def change
    create_table :progresses do |t|
      t.references :user, foreign_key: { to_table: :users}, null: false
      t.string :date, null: false
      t.integer :points, null: false

      t.timestamps
    end
  end
end
