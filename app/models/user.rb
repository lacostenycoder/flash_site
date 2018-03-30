class User < ApplicationRecord
  FORGOT_PASSWORD_LINK_EXPIRY_TIME = 24.hours
  validates :first_name, :last_name, :email, presence: true
  validates :first_name, :last_name, length: { maximum: 255 }, allow_blank: true
  validates :email, uniqueness: true, allow_blank: true
  validates :password, :password_confirmation, presence: true, on: :update

  has_many :orders
  has_many :addresses

  has_secure_password

  before_create :set_confirm_token, unless: :user_is_admin?
  after_commit :send_registration_mail, unless: :user_is_admin?

  delegate :fullname, to: :presenter
  attr_accessor :remember_me

  def activate_email
    update_columns(confirm_token: nil)
  end

  def presenter
    @presenter ||= UserPresenter.new(self)
  end

  def reset_password_link_expired?
    Time.current - reset_password_token_set_at > FORGOT_PASSWORD_LINK_EXPIRY_TIME
  end

  def send_forgot_password_email
    update_columns(reset_password_token: SecureRandom.urlsafe_base64.to_s, reset_password_token_set_at: Time.current)
    UserMailer.forgot_password(id).deliver_later
  end

  def nullify_reset_password_token
    update_attribute(:reset_password_token, nil)
  end

  def cart
    orders.find_or_create_by(state: :cart)
  end

  def addressed_cart
    orders.find_by(state: :address)
  end

  private
    def set_confirm_token
      self.confirm_token ||= SecureRandom.urlsafe_base64.to_s
    end

    def send_registration_mail
      UserMailer.registration_mail(id).deliver_later
    end

    def user_is_admin?
      type == 'Admin'
    end

end
