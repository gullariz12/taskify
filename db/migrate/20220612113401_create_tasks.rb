class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :description, limit: 255
      t.boolean :completed

      t.timestamps
    end
  end
end
