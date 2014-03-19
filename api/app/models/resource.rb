# id              integer, not null
# name            varchar(255), not null
# url             varchar(255), default "", not null
# description     varchar(255), default "", not null
# uuid            varchar(40), index
# created_at      datetime
# updated_at      datetime

class Resource < ActiveRecord::Base
  before_save :generate_uuid

  belongs_to :resource_type
  belongs_to :license
  belongs_to :user
  has_and_belongs_to_many :tags

  validates :name, presence: true
  validates :url, presence: true
  validates :description, presence: true

  def generate_uuid
    begin
      self.uuid = SecureRandom.uuid
    end while self.class.exists? uuid: uuid
  end
end
