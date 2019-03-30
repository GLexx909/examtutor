class CreateEssayPassages < ActiveRecord::Migration[5.2]
  def change
    create_table :essay_passages do |t|
      t.references :user, foreign_key: true
      t.references :essay, foreign_key: true
      t.string :body, null: false
      t.boolean :status, default: false

      t.timestamps
    end
  end
end
