# id              integer, not null
# tag             varchar(50), not null
# uuid            varchar(40), index
# created_at      datetime
# updated_at      datetime

class Tag < ActiveRecord::Base
  has_and_belongs_to_many :resources

  before_save :generate_uuid

  validates :tag, presence: true,
                  length: { maximum: 50 },
                  uniqueness: true

  def generate_uuid
    begin
      self.uuid = SecureRandom.uuid
    end while self.class.exists? uuid: uuid
  end
end
