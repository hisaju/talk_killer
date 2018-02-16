class Talk < ActiveRecord::Base
    validates :title,   presence: true
    validates :content, presence: true
    belongs_to :user
    has_many :comments,  dependent: :destroy
    has_many :replies,   dependent: :destroy
    has_many :summaries, dependent: :destroy
    mount_uploader :picture, PictureUploader
    enum status:    %i(緊急 重要 提案 告知 解決)
    enum templates: %i(全員 グループA グループB グループC)
end
