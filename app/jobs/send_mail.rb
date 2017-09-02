class SendMail
  include Sidekiq::Worker

  def perform (*args)
    if args[0]["all_user"].present? && args[0]["more_email"].present?
      users = Spree::User.all
      mails = users.map{|user| user.email}.concat(args[0]["more_email"].split(","))
    elsif args[0]["all_user"].blank? && args[0]["more_email"].present?
      mails = args[0]["more_email"]
    elsif args[0]["all_user"].present? && args[0]["more_email"].blank?
      users = Spree::User.all
      mails = users.map{|user| user.email}
    end
    Spree::MagazineMailer.send_all_user(mails, args[0]["title"], args[0]["template"], args[0]["bcc"]).deliver_now
  end
end
