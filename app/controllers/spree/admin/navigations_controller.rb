module Spree
  module Admin
    class NavigationsController < ResourceController
      def new
        @new_navigation = Spree::Navigation.new
        @taxonomies = Spree::Taxonomy.all
      end

      def edit
        @taxonomies = Spree::Taxonomy.all
      end

      def create
        ActiveRecord::Base.transaction do
          navigation = Spree::Navigation.create! name: params[:navigation][:name],
            image: params[:navigation][:image], taxonomy_ids: params[:navigation][:taxonomy_ids].drop(1).join(','),
            link_navigation: params[:navigation][:link_navigation], link_image: params[:navigation][:link_image]
          if params[:sub_navigations].present?
            params[:sub_navigations].each_with_index do |name, index|
              Spree::Navigation.create!(name: name, link_navigation: params[:link_navigations][index], parent_navigation_id: navigation.id) if name.present?
            end
          end
          redirect_to admin_navigations_path
        end
        rescue Exception => e
          flash[:error] = e.message
          redirect_to :back
      end

      def update
        navigation = Spree::Navigation.find(params[:id])
        params_update_nav = params[:sub_navigations].select{|abc| navigation.sub_navigations.pluck(:id).include?(abc[:id].to_i)}
        Spree::Navigation.where(id: navigation.sub_navigations.pluck(:id)).each_with_index do |navi_update, index|
          navi_update.update(name: params_update_nav[index][:name], link_navigation: params_update_nav[index][:link_navigation])
        end
        more_sub_navigate = params[:sub_navigations].select{|navi| navi[:id].blank?}
        more_sub_navigate.each do |more_sub_navi|
          Spree::Navigation.create!(name: more_sub_navi[:name], parent_navigation_id: navigation.id,
            link_navigation: more_sub_navi[:link_navigation])
        end
        if params[:navigation][:image].present?
          navigation.update name: params[:navigation][:name],
            image: params[:navigation][:image], taxonomy_ids: params[:navigation][:taxonomy_ids].drop(1).join(','),
            link_navigation: params[:navigation][:link_navigation], link_image: params[:navigation][:link_image]
        else
          navigation.update name: params[:navigation][:name],
            taxonomy_ids: params[:navigation][:taxonomy_ids].drop(1).join(','),
            link_navigation: params[:navigation][:link_navigation], link_image: params[:navigation][:link_image]
        end
        redirect_to admin_navigations_path
      end
    end
  end
end
