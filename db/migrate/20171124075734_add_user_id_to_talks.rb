class AddUserIdToTalks < ActiveRecord::Migration
  def change
    add_column :talks, :user_id, :integer
  end
end
