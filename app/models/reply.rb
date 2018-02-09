class Reply < ActiveRecord::Base
  validates :content, presence: true
  belongs_to :user
  belongs_to :talk
  belongs_to :comment
end
