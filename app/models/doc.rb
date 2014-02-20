# id              integer, not null
# title           varchar(100), not null
# content         text, not null
# method          varchar(10), default "", not null
# created_at      datetime
# updated_at      datetime

class Doc < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title_and_method, use: [:slugged, :finders]

  METHODS = [:no_method, :get, :put, :post, :delete]
  METHODS_SWE = ['Ingen', 'GET', 'PUT', 'POST', 'DELETE']

  scope :api, -> { where.not(method: :no_method) }
  scope :other, -> { where(method: :no_method) }
  scope :changelog, -> { where(title: "Changelog").first }

  validates :title, presence: true,
                    length: { maximum: 100 }

  validates :content, presence: true

  validates :method, inclusion: { in: METHODS }

  def method
    read_attribute(:method).to_sym
  end

  def method= value
    write_attribute :method, value.to_s
  end

  def api?
    method != :no_method
  end

  def title_and_method
    if read_attribute(:method).to_sym == :no_method
      "#{title}"
    else
      "#{method} #{title}"
    end
  end
end
