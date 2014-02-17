# id              integer, not null
# name            varchar(255), not null
# url             varchar(255), default "", not null
# description     varchar(255), default "", not null
# created_at      datetime
# updated_at      datetime

class Resource < ActiveRecord::Base
  belongs_to :resource_type
  belongs_to :license
  belongs_to :user
  has_and_belongs_to_many :tags

  validates :name, presence: true
  validates :url, presence: true
  validates :description, presence: true
end
