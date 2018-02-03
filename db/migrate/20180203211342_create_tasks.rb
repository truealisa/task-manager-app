class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.string :name
      t.boolean :status
      t.references :project, foreign_key: true
      t.string :deadline
      t.string :priority

      t.timestamps
    end
  end
end
