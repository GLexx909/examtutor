class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.string :title
      t.integer :abonent
      t.string :link
      t.boolean :status, default: false

      t.timestamps
    end
  end
end
