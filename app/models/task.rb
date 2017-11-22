class Task < ActiveRecord::Base
    enum status: %i(urgent important todo someday)
end
