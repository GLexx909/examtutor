class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.string :title
      t.references :abonent, foreign_key: { to_table: :users }
      t.references :author, foreign_key: { to_table: :users }
      t.string :type_of
      t.string :link
      t.boolean :status, default: false

      t.timestamps
    end
  end
end
