module Spree
  class HomeController < Spree::StoreController
    helper 'spree/products'
    respond_to :html

    def index
      @searcher = build_searcher(params.merge(include_images: true))
      @products = @searcher.retrieve_products
      @products = @products.includes(:possible_promotions) if @products.respond_to?(:includes)
      @taxonomies = Spree::Taxonomy.includes(root: :children)
      @features = Spree::SpecialProduct.special('featured').visible.limit(10)
      @bestsellers = Spree::SpecialProduct.special('bestseller').visible.limit(10)
      @saleoffs = Spree::SpecialProduct.special('saleoff').visible.limit(10)
      @newproducts = Spree::Product.order(created_at: :desc).limit(10)
      @sliders = Spree::Slider.limit(3).order(created_at: :desc)
    end
  end
end
