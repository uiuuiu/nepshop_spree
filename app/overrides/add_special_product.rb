Deface::Override.new(:virtual_path => "spree/layouts/admin",
                     :name => "add_special_product",
                     :insert_bottom => "#main-sidebar",
                     :text => " <% if can? :admin, Spree::SpecialProductType %>
                                  <ul class='nav nav-sidebar'>
                                    <%= main_menu_tree Spree.t(:special_product), icon: 'transfer ',
                                      sub_menu: 'sub_special_product', url: '#sidebar-special-product' %>
                                  </ul>
                                <% end %>")
