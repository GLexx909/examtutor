class CreateModulPassages < ActiveRecord::Migration[5.2]
  def change
    create_table :modul_passages do |t|
      t.references :user, foreign_key: true
      t.references :modul, foreign_key: true
      t.boolean :status

      t.timestamps
    end
  end
end
