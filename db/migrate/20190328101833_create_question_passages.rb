class CreateQuestionPassages < ActiveRecord::Migration[5.2]
  def change
    create_table :question_passages do |t|
      t.references :user, foreign_key: true
      t.references :question, foreign_key: true
      t.string :answer

      t.timestamps
    end
  end
end
