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

  def self.search query
    if query.blank?
      scoped
    else
      q = "%#{query}%"
      where("name like ? or description like ?", q, q)
    end
  end

  def generate_uuid
    begin
      self.uuid = SecureRandom.uuid
    end while self.class.exists? uuid: uuid
  end

  def tags= new_tags
    self.tags.delete_all

    unless new_tags.empty?
      new_tags = JSON.parse(new_tags) if new_tags.is_a?(String)

      new_tags.each do |tag|
        self.tags << Tag.find_or_create_by_tag(tag)
      end
    end
  end

  def resource_type_id= uuid
    self.resource_type = ResourceType.find_by_uuid(uuid)
  end

  def license_id= uuid
    self.license = License.find_by_uuid(uuid)
  end
end
