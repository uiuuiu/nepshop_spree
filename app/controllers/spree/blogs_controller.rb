module Spree
  class BlogsController < Spree::StoreController
    def show
      @taxonomies = Spree::Taxonomy.all
      @blog = Spree::Blog.find(params[:id])
    end

    def index
      @taxonomies = Spree::Taxonomy.all
      @blogs = Spree::Blog.where(status: 1).where("publish_date <= ?", DateTime.now)
    end
  end
end
