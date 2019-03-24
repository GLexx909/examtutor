class CreateEssayPassages < ActiveRecord::Migration[5.2]
  def change
    create_table :essay_passages do |t|
      t.references :user, foreign_key: true
      t.references :essay, foreign_key: true
      t.string :body, null: false
      t.string :tutor_note, optional: true
      t.string :status, default: 'false' #false, rejected, approved

      t.timestamps
    end
  end
end
