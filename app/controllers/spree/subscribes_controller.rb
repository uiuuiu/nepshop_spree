module Spree
  class SubscribesController < Spree::StoreController
    def create
      subscribe = Spree::Subscribe.new email: params[:subscribe][:email]
      if subscribe.save
        Spree::SubscribeMailer.send_mail_user(subscribe.email, "Subscribe success").deliver_later
        @message = ["Subscribe success", "green"]
      else
        @message = ["Email not valid", "red"]
      end
      respond_to do |format|
        format.js
      end
    end
  end
end
