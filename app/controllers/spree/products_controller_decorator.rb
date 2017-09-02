Spree::ProductsController.class_eval do
  def show
    @tags = Spree::Tag.all
    @variants = @product.variants_including_master.
                           spree_base_scopes.
                           active(current_currency).
                           includes([:option_values, :images])
    @product_properties = @product.product_properties.includes(:property)
    @taxon = params[:taxon_id].present? ? Spree::Taxon.find(params[:taxon_id]) : @product.taxons.first
    redirect_if_legacy_path
  end
end
