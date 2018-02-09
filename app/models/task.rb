class Task < ActiveRecord::Base
    validates :title,   presence: true
    validates :content, presence: true
    belongs_to :user
    enum status: %i(緊急 重要 なるはや いつか)
end
