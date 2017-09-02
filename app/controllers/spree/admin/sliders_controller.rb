module Spree
  module Admin
    class SlidersController < ResourceController
      def create
        slider = Spree::Slider.create!(title: params[:slider][:title].join(','),
          link: params[:slider][:link], background: params[:slider][:background],
          logo: params[:slider][:logo])
        flash[:success] = "Create slider complete" if slider
        redirect_to admin_sliders_path
      end

      def update
        slider = Spree::Slider.find(params[:id])
        slider.update!(title: params[:slider][:title].join(','),
          link: params[:slider][:link])
        slider.update!(background: params[:slider][:background]) if params[:slider][:background].present?
        slider.update!(logo: params[:slider][:logo]) if params[:slider][:logo]
        flash[:success] = "Update slider complete"
        redirect_to admin_sliders_path
      end
    end
  end
end
