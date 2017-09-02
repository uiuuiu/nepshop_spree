module Spree
  module Admin
    class MailsController < ResourceController
      def new
        @magazines = Spree::Magazine.all
        super
      end

      def create
        ActiveRecord::Base.transaction do
          invoke_callbacks(:create, :before)
          @object.attributes = permitted_resource_params
          if @object.save
            invoke_callbacks(:create, :after)
            Sidekiq::Cron::Job.create(name: "#{@object.spree_magazine.title}",
                              cron: @object.date_time.to_time.strftime('%M %H %d %m %u'),
                              class: 'SendMail',
                              args: {more_email: @object.more_email, all_user: @object.all_user,
                                title: @object.spree_magazine.title, template: @object.spree_magazine.content,
                                bcc: @object.bcc}
                              )
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
        rescue Exception => e
          puts e.message
      end

      def edit
        @magazines = Spree::Magazine.all
        super
      end

      def update
        ActiveRecord::Base.transaction do
          Sidekiq::Cron::Job.find(name: Spree::Mail.find(params[:id]).spree_magazine.title).destroy
          invoke_callbacks(:update, :before)
          if @object.update_attributes(permitted_resource_params)
            invoke_callbacks(:update, :after)
            Sidekiq::Cron::Job.create(name: "#{@object.spree_magazine.title}",
                              cron: @object.date_time.to_time.strftime('%M %H %d %m %u'),
                              class: 'SendMail',
                              args: {more_email: @object.more_email, all_user: @object.all_user,
                                title: @object.spree_magazine.title, template: @object.spree_magazine.content,
                                bcc: @object.bcc}
                              )

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
        rescue Exception => e
          puts e.message
      end
    end
  end
end
