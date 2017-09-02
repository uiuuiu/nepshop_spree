module Spree::HomeHelper
  def list_navigations
    Spree::Navigation.all
  end

  def list_taxonomies taxonomy_ids
    Spree::Taxonomy.where(id: taxonomy_ids)
  end

  def list_blogs
    Spree::Blog.where(status: 1).where("publish_date <= ?", DateTime.now).order(position: :asc).limit(2)
  end
end
