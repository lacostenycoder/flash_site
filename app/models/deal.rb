class Deal < ApplicationRecord
  has_many :images, as: :imageable, dependent: :destroy
  has_many :line_items
  has_many :orders, through: :line_items

  accepts_nested_attributes_for :images, allow_destroy: true

  validates :title, :description, :price, :discounted_price, :quantity, :publish_date, presence: true
  validate :price_greater_than_discounted_price?
  validates :description, length: { maximum: 255 }
  validate :check_state_and_publish_date, on: :update

  before_create :set_state_and_code
  after_update :update_state

  scope :published_on, -> (date = Date.current){ where(publish_date: date) }
  scope :published_deals, -> { includes(:images).where(state: :published) }
  scope :past_deals, -> { includes(:images).where(state: :over).order(publish_date: :desc) }

  enum state: [:non_publishable, :publishable, :published, :over]

  def set_state_and_code
    set_state
    set_code
  end

  def update_state(state = set_state)
    update_columns(state: state)
  end

  private
    def is_publishable?
      images.size >= 2 && quantity > 10 && number_of_deals_on_same_date < 3
    end

    def check_state_and_publish_date
      if (published? || over?) && publish_date_changed?
        errors.add(:base, :publish_date_readonly)
      end
    end

    def set_state
      if is_publishable?
        self.state = :publishable
      else
        self.state = :non_publishable
      end
    end

    def set_code
      self.code = "deal-" + SecureRandom.urlsafe_base64(8)
    end

    def number_of_deals_on_same_date
      self.class.published_on(publish_date).size
    end

    def update_quantity
      self.update_columns(quantity: quantity - 1)
    end


    def price_greater_than_discounted_price?
      errors.add(:discounted_price, :dicount_price_greater) unless price >= discounted_price
    end
end
