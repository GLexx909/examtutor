class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.references :author, foreign_key: { to_table: :users }
      t.references :abonent, foreign_key: { to_table: :users }
      t.string :body
      t.boolean :status, default: false

      t.timestamps
    end
  end
end
