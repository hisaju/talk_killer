class AddPictureToTalks < ActiveRecord::Migration
  def change
    add_column :talks, :picture, :string
  end
end
