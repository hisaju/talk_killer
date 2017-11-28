class Talk < ActiveRecord::Base
    belongs_to :user
    has_many :comments,  dependent: :destroy
    has_many :replies,   dependent: :destroy
    has_many :summaries, dependent: :destroy
    enum status:    %i(緊急 重要 提案 告知 解決)
    enum templates: %i(announce discussion question debate)
end
