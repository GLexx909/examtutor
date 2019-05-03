class CreateFeedbacks < ActiveRecord::Migration[5.2]
  def change
    create_table :feedbacks do |t|
      t.references :user, foreign_key: true
      t.text :body, null: false
      t.boolean :moderation, default: false
      t.boolean :approved, default: false

      t.timestamps
    end
  end
end
