class Resource < ActiveRecord::Base
  belongs_to :resource_type
  belongs_to :license
  belongs_to :user
  has_and_belongs_to_many :tags
end
