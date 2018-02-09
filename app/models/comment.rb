class Comment < ActiveRecord::Base
  validates :content, presence: true
  belongs_to :user
  belongs_to :talk
  has_many :replies,  dependent: :destroy
end
