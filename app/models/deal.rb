class Deal < ApplicationRecord
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true

  validates :title, :description, :price, :discounted_price, :quantity, :publish_date, presence: true

  before_create :initialize_deal, :is_publishable?
  before_update :check_deal_publishability

  enum state: [:non_publishable, :publishable, :published, :over]

  def initialize_deal
    self.state = :non_publishable
    self.code = "deal-" + SecureRandom.urlsafe_base64(8)
  end

  def is_publishable?
    if images.size >= 2 && quantity > 10 && deals_on_same_date < 3
      self.state = :publishable
    end
  end


  # call when deal is published at 10am
  def set_deal_published
    self.update_columns(state: :published)
  end
  # call when deal;s 24 hours are done
  def set_deal_over
    self.update_columns(state: :over)
  end


  def check_deal_publishability
    if !is_publishable?
      errors.add(:base, t('.not_publishable'))
      throw :abort
    end

    if published? || over?
      if publish_date_changed?
        errors.add(:base, t('.publish_date_readonly'))
        throw :abort
      end
    end
  end

  private
    def deals_on_same_date
      Deal.where(publish_date: publish_date).size
    end
end
