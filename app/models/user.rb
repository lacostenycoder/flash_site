class User < ApplicationRecord
  FORGOT_PASSWORD_LINK_EXPIRY_TIME = 24.hours
  validates :first_name, :last_name, :email, presence: true
  validates :first_name, :last_name, length: { maximum: 255 }, allow_blank: true
  validates :email, uniqueness: true, allow_blank: true
  validates :password, :password_confirmation, presence: true, on: :update
  validates :type, inclusion: { in: %w(Customer Admin) }

  has_secure_password

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

  def admin?
    type == 'Admin'
  end
end
