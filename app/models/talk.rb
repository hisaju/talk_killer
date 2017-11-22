class Talk < ActiveRecord::Base
    enum status: %i(urgent important propose notice closed)
    enum templates: %i(announce discussion question debate)
end
