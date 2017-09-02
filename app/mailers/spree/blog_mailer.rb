module Spree
  class BlogMailer < ApplicationMailer
    def send_mail object, email, subject
      @object = object
      mail(to: email, subject: subject)
    end
  end
end
