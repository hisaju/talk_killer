class Reply < ActiveRecord::Base
  belongs_to :user
  belongs_to :talk
  belongs_to :comment
end
