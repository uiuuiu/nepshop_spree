Deface::Override.new(
  virtual_path: 'spree/layouts/admin',
  name: 'pages_admin_sidebar_menu',
  insert_bottom: '#main-sidebar',
  text: "
          <ul class='nav nav-sidebar'>
            <%= main_menu_tree 'Pages', icon: 'leaf',
              sub_menu: 'sub_page', url: '#sidebar-pages' %>
          </ul>
        "
)
