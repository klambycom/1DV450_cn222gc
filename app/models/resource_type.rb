# id              integer, not null
# name            varchar(50), not null
# uuid            varchar(40), index
# created_at      datetime
# updated_at      datetime

class ResourceType < ActiveRecord::Base
  has_many :resources

  before_save :generate_uuid

  validates :name, presence: true,
                   length: { maximum: 50 },
                   uniqueness: true

  def generate_uuid
    begin
      self.uuid = SecureRandom.uuid
    end while self.class.exists? uuid: uuid
  end
end
