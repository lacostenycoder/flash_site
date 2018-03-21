class Customer < User
  before_create :set_confirm_token
  after_commit :send_registration_mail

  private
    def set_confirm_token
      self.confirm_token ||= SecureRandom.urlsafe_base64.to_s
    end

    def send_registration_mail
      UserMailer.registration_mail(id).deliver_later
    end
end
