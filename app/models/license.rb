# id              integer, not null
# name            varchar(255), not null
# description     text, not null
# url             varchar(255), not null
# created_at      datetime
# updated_at      datetime

class License < ActiveRecord::Base
  has_many :resources

  validates :name, presence: true,
                   uniqueness: true

  validates :description, presence: true
  validates :url, presence: true, format: URI::regexp(%w(http https))
end
