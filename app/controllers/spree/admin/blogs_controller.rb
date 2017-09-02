module Spree
  module Admin
    class BlogsController < ResourceController
      def create
        invoke_callbacks(:create, :before)
        @object.attributes = permitted_resource_params
        if @object.save
          if @object.status == 1
            mails_sub = Spree::Subscribe.all.pluck(:email)
            Spree::BlogMailer.send_mail(@object, mails_sub, "James-Shop have new blog").deliver_later
          end
          invoke_callbacks(:create, :after)
          flash[:success] = flash_message_for(@object, :successfully_created)
          respond_with(@object) do |format|
            format.html { redirect_to location_after_save }
            format.js   { render layout: false }
          end
        else
          invoke_callbacks(:create, :fails)
          respond_with(@object) do |format|
            format.html { render action: :new }
            format.js { render layout: false }
          end
        end
      end

      def update
        invoke_callbacks(:update, :before)
        if @object.update_attributes(permitted_resource_params)
          if @object.status == 1
            mails_sub = Spree::Subscribe.all.pluck(:email)
            Spree::BlogMailer.send_mail(@object, mails_sub, "James-Shop have new blog").deliver_later
          end
          invoke_callbacks(:update, :after)
          respond_with(@object) do |format|
            format.html do
              flash[:success] = flash_message_for(@object, :successfully_updated)
              redirect_to location_after_save
            end
            format.js { render layout: false }
          end
        else
          invoke_callbacks(:update, :fails)
          respond_with(@object) do |format|
            format.html { render action: :edit }
            format.js { render layout: false }
          end
        end
      end
    end
  end
end
