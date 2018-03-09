class User < ApplicationRecord
  validates :first_name, :last_name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, uniqueness: true
  validates :password, :password_confirmation, presence: true, on: :update
  has_secure_password

  before_create :set_confirm_token
  after_commit :send_registration_mail

  def email_activated
    self.confirm_token = nil
    save!(validate: false)
  end

  private
    def set_confirm_token
      self.confirm_token ||= SecureRandom.urlsafe_base64.to_s
    end

    def send_registration_mail
      UserMailer.registration_mail(id).deliver_later
    end

end
