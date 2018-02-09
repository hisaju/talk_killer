class Summary < ActiveRecord::Base
  validates :content, presence: true
  belongs_to :user
  belongs_to :talk
end
