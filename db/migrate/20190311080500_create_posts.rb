class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :body
      t.boolean :for_guests, default: false
      t.references :author, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
