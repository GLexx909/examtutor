class CreateTestPassages < ActiveRecord::Migration[5.2]
  def change
    create_table :test_passages do |t|
      t.references :user, foreign_key: true
      t.references :test, foreign_key: true
      t.integer :points, default: 0
      t.integer :left_time
      t.boolean :status, default: false

      t.timestamps
    end
  end
end
