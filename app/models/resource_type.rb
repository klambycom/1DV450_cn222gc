# id              integer, not null
# name            varchar(50), not null
# created_at      datetime
# updated_at      datetime

class ResourceType < ActiveRecord::Base
  has_many :resources

  validates :name, presence: true,
                   length: { maximum: 50 },
                   uniqueness: true
end
