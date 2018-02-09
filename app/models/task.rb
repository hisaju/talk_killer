class Task < ActiveRecord::Base
    belongs_to :user
    enum status: %i(緊急 重要 なるはや いつか)
end
