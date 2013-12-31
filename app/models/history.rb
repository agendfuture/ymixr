class History < ActiveRecord::Base
  belongs_to :user
  belongs_to :song

  self.per_page = 15
end
