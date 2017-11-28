class CreateSummaries < ActiveRecord::Migration
  def change
    create_table :summaries do |t|
      t.references :user, index: true, foreign_key: true
      t.references :talk, index: true, foreign_key: true
      t.text :content

      t.timestamps null: false
    end
  end
end
