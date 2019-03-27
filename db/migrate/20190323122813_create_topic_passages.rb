class CreateTopicPassages < ActiveRecord::Migration[5.2]
  def change
    create_table :topic_passages do |t|
      t.references :user, foreign_key: true
      t.references :topic, foreign_key: true
      t.boolean :status, default: false

      t.timestamps
    end
  end
end
