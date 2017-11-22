class CreateTalks < ActiveRecord::Migration
  def change
    create_table :talks do |t|
      t.string  :title
      t.string  :content
      t.string  :summary
      t.string  :template
      t.integer :status
      t.date    :due_date

      t.timestamps null: false
    end
  end
end
