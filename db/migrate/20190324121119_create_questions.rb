class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.belongs_to :questionable, polymorphic: true
      t.text :title, null: false

      t.timestamps
    end
  end
end
