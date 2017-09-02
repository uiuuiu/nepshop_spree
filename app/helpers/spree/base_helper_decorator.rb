module Spree::BaseHelper
  def breadcrumbs(taxon, separator="&nbsp;")
    #return "" if current_page?("/") || taxon.nil?
    separator = raw(separator)
    crumbs = [content_tag(:li, content_tag(:span, link_to(content_tag(:span, Spree.t(:home), itemprop: "name"), spree.root_path, itemprop: "url") + separator, itemprop: "item"), itemscope: "itemscope", itemtype: "https://schema.org/ListItem", itemprop: "itemListElement")]
    if taxon
      crumbs << content_tag(:li, content_tag(:span, link_to(content_tag(:span, Spree.t(:products), itemprop: "name"), spree.products_path, itemprop: "url") + separator, itemprop: "item"), itemscope: "itemscope", itemtype: "https://schema.org/ListItem", itemprop: "itemListElement")
      crumbs << taxon.ancestors.collect { |ancestor| content_tag(:li, content_tag(:span, link_to(content_tag(:span, ancestor.name, itemprop: "name"), seo_url(ancestor), itemprop: "url") + separator, itemprop: "item"), itemscope: "itemscope", itemtype: "https://schema.org/ListItem", itemprop: "itemListElement") } unless taxon.ancestors.empty?
      crumbs << content_tag(:li, content_tag(:span, link_to(content_tag(:span, taxon.name, itemprop: "name") , seo_url(taxon), itemprop: "url"), itemprop: "item"), class: 'active', itemscope: "itemscope", itemtype: "https://schema.org/ListItem", itemprop: "itemListElement")
    else
      crumbs << content_tag(:li, content_tag(:span, Spree.t(:products), itemprop: "item"), class: 'active', itemscope: "itemscope", itemtype: "https://schema.org/ListItem", itemprop: "itemListElement")
    end
    crumb_list = content_tag(:ul, raw(crumbs.flatten.map{|li| li.mb_chars}.join), itemscope: "itemscope", itemtype: "https://schema.org/BreadcrumbList")
    content_tag(:nav, crumb_list)
  end

  def is_homepage?
    current_page?("/")
  end

  def block_to_cart(text = nil)
    text = text ? h(text) : Spree.t('Shopping cart')
    item_count = 0
    total = 0;
    unless simple_current_order.nil? or simple_current_order.item_count.zero?
      item_count = simple_current_order.item_count
      total = simple_current_order.display_total.to_html
    end

    content = content_tag(:div, text, class: 'cart_title')
    content += content_tag(:div, class: 'cart_details') do
      content_tag(:span, pluralize(item_count, 'item') ) +
      content_tag(:span, "", class: 'border_cart') +
      content_tag(:span, "Total: #{total}", class: "price")
    end
    content += content_tag(:div, class: 'cart_icon') do
      link_to image_tag('shoppingcart.png'), spree.cart_path
    end
    content
  end

  def taxons_tree(root_taxon, current_taxon, max_level = 1)
    return '' if max_level < 1 || root_taxon.leaf?
    content_tag :ul do
      taxons = root_taxon.children.map do |taxon|
        css_class = (current_taxon && current_taxon.self_and_ancestors.include?(taxon)) ? 'active' : ''
        content_tag :li, class: css_class do
          link_to(taxon.name, seo_url(taxon)) +
          if taxon.children.any?
            taxons_tree(taxon, current_taxon, max_level = 1)
          end
        end
      end
      safe_join(taxons, "\n")
    end
  end

  def get_image_path(image)
    Nokogiri::HTML(image).xpath("//img")[0]['src']
  end

  def image_two_products(product)
    images = ''
    product.images.limit(2).each do |i|
      klass = product.images.size == 1 ? '' : "#{cycle('primary-img', 'secondary-img')}"
      images += image_tag(i.attachment.url(:product), class: "#{klass}")
    end
    images.html_safe
  end

  def link_to_cart
    if simple_current_order.nil? or simple_current_order.item_count.zero?
      text = "#{image_tag'icon-cart.png'} <span>0</span>"
    else
      text = "#{image_tag'icon-cart.png'}<span> #{simple_current_order.line_items.size}</span>"
    end
    link_to text.html_safe, spree.cart_path
  end

  def paypal_url(order, return_path)
    values = {
      "business"=> "thap.spdn-facilitator@gmail.com",
      "cmd"=> "_cart",
      "upload" => 1,
      "return"=> "http://localhost:3000#{return_path}",
      "invoice"=> order.number,
      "currencyCode" => order.currency,
      "amount"=> order.total,
      "tax_cart" => order.additional_tax_total,
    }
    order.line_items.each_with_index do |item, index|
      values.merge!({
        "item_name_#{index+1}" => item.name,
        "item_number_#{index+1}" => item.sku,
        "quantity_#{index+1}" => item.quantity,
        "amount_#{index+1}" => item.price,
        "shipping_#{index+1}" => (order.shipment_total)/(order.line_items.size)
      });
    end
    "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
  end
end
