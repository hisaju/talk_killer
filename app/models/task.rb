class Task < ActiveRecord::Base
    belongs_to :user
    enum status: %i(urgent important todo someday)
end
