class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :talk
  has_many :replies,  dependent: :destroy
end
