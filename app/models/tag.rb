# id              integer, not null
# tag             varchar(50), not null
# created_at      datetime
# updated_at      datetime

class Tag < ActiveRecord::Base
  has_and_belongs_to_many :resources

  validates :tag, presence: true,
                  length: { maximum: 50 },
                  uniqueness: true
end
