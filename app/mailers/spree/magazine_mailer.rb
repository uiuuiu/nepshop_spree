module Spree
  class MagazineMailer < ApplicationMailer
    def send_all_user(mails, title, template, bcc)
      @title = title
      @template = template
      mail(to: mails, subject: title, bcc: bcc)
    end
  end
end
