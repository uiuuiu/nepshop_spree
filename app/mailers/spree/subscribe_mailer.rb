module Spree
  class SubscribeMailer < ApplicationMailer
    def send_mail_user email, subject
      mail(to: email, subject: subject)
    end
  end
end
