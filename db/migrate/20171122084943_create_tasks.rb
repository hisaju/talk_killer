class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.integer :status
      t.date :due_date
      t.boolean :event
      t.boolean :done

      t.timestamps null: false
    end
  end
end
