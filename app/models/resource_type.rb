# id              integer, not null
# type            varchar(50), not null
# created_at      datetime
# updated_at      datetime

class ResourceType < ActiveRecord::Base
  has_many :resources

  validates :type, presence: true,
                   length: { maximum: 50 },
                   uniqueness: true
end
