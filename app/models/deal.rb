class Deal < ApplicationRecord
  has_many :images, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true

  validates :title, :description, :price, :discounted_price, :quantity, :publish_date, presence: true
  validate :price_greater_than_discounted_price
  validates :description, length: { maximum: 255, message: 'must be shorter' }
  validate :check_state, on: :update

  before_create :setup_deal
  after_update :set_state, :update_state

  scope :published_on, -> (date = Date.today){ where(publish_date: date) }

  enum state: [:non_publishable, :publishable, :published, :over]

  def setup_deal
    set_state
    set_code
  end

  def update_state(state = self.state)
    update_columns(state: state)
  end

  private
    def is_publishable?
      images.size >= 2 && quantity > 10 && deals_on_same_date < 3
    end

    def check_state
      if (published? || over?) && publish_date_changed?
        errors.add(:base, :publish_date_readonly)
      end
    end

    def set_state
      self.state = :non_publishable
      if is_publishable?
        self.state = :publishable
      end
    end

    def set_code
      self.code = "deal-" + SecureRandom.urlsafe_base64(8)
    end

    def deals_on_same_date
      Deal.published_on(publish_date).size
    end

    def price_greater_than_discounted_price
      errors.add(:discounted_price, "can't be greater than price") unless price >= discounted_price
    end
end
