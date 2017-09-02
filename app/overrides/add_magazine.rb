Deface::Override.new(:virtual_path => "spree/layouts/admin",
                     :name => "add_magazine",
                     :insert_bottom => "#main-sidebar",
                     :text => " <% if can? :admin, Spree::Magazine %>
                                  <ul class='nav nav-sidebar'>
                                    <%= main_menu_tree 'Magazines', icon: 'send shipment',
                                      sub_menu: 'sub_magazine', url: '#sidebar-magazines' %>
                                  </ul>
                                <% end %>")
