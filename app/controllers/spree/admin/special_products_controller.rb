module Spree
  module Admin
    class SpecialProductsController < ResourceController

      def index
        @special_products = Spree::SpecialProduct.includes(:product, :special_product_type)
      end

      def new
        @special_product_types = Spree::SpecialProductType.all
      end

      def create
        @special_product = Spree::SpecialProduct.new(special_params)
        @special_product.spree_product_id = Spree::Variant.find(special_params[:spree_product_id]).product.id
        @special_product.save

        redirect_to admin_special_products_path
      end

      def edit
        @special_product_types = Spree::SpecialProductType.all
        @special_product = Spree::SpecialProduct.find(params[:id])
      end

      def update
        special_product = Spree::SpecialProduct.find(params[:id])
        special_product.update! special_params
        redirect_to admin_special_products_path
      end

      private

      def special_params
        params.require(:special_product).permit(:spree_product_id, :spree_special_product_type_id, :visible)
      end

    end
  end
end
