# id              integer, not null
# name            varchar(255), not null
# description     text, not null
# url             varchar(255), not null
# uuid            varchar(40), index
# created_at      datetime
# updated_at      datetime

class License < ActiveRecord::Base
  has_many :resources

  before_save :generate_uuid

  validates :name, presence: true,
                   uniqueness: true

  validates :description, presence: true
  validates :url, presence: true, format: URI::regexp(%w(http https))

  def generate_uuid
    begin
      self.uuid = SecureRandom.uuid
    end while self.class.exists? uuid: uuid
  end
end
