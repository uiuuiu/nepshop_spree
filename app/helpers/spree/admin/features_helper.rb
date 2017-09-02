module Spree::Admin::FeaturesHelper
	def available_status(feature) # will return a human readable string
      return Spree.t(:discontinued)  if feature.discontinued?
      return Spree.t(:deleted)  if feature.deleted?

      if feature.available?
        Spree.t(:available)
      elsif feature.available_on && feature.available_on.future?
        Spree.t(:pending_sale)
      else
        Spree.t(:no_available_date_set)
      end
    end
end
