class Task < ActiveRecord::Base
    validates :title,   presence: true
    belongs_to :user
    mount_uploader :picture, PictureUploader
    enum status: %i(緊急 重要 なるはや いつか)
end
