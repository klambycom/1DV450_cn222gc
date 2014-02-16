class Resource < ActiveRecord::Base
  belongs_to :resource_type
  belongs_to :license
  belongs_to :user
end
