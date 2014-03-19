# id              integer, not null
# firstname       varchar(255), not null
# lastname        varchar(255), not null
# email           varchar(254), not null
# password_digest varchar(255), not null
# uuid            varchar(40), index
# created_at      datetime
# updated_at      datetime

class User < ActiveRecord::Base
  has_secure_password

  before_save :generate_uuid

  has_many :resources
  has_many :applications, class_name: 'Doorkeeper::Application', as: :owner

  validates :firstname, presence: true
  validates :lastname, presence: true

  validates :email, presence: { message: "Du måste ange en e-postadress" },
                    uniqueness: true

  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,
                              presence: { message: "Felaktig e-postadress" }

  def generate_uuid
    begin
      self.uuid = SecureRandom.uuid
    end while self.class.exists? uuid: uuid
  end
end
