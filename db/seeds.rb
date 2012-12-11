Role.create([{:name => "admin"}, {:name => "moderator"}])

Dust::User.create(:username => 'admin', :password => "secret", :email => 'admin@dust', :role => Role.find_by_name("admin"))

Dust::Page.create([{:nav_link => 'Welcome', :meta_title => "Welcome", :active => 1, :filename => "welcome"}])

Dust::CmsMenuItem.create([{:title =>"Home", :controller_name => "front_end/pages", :url => "/"}, 
	{:title =>"Pages", :controller_name => "admin/pages", :url => "admin/pages"}, 
	{:title =>"Blocks", :controller_name => "admin/blocks", :url => "admin/blocks"},
	{:title =>"Contacts", :controller_name => "admin/contacts", :url => "admin/contacts"}, 
	{:title =>"Roles", :controller_name => "admin/roles", :url => "admin/roles"}, 
	{:title =>"Users", :controller_name => "admin/users", :url => "admin/users"}, 
	{:title =>"Menu Items", :controller_name => "admin/menu_items", :url => "admin/menu_items"}, 
	{:title =>"Manage Menu", :controller_name => "admin/pages", :url => "admin/menu-manage"}, 	
	{:title =>"Dust Menu Items", :controller_name => "admin/cms_menu_items", :url => "admin/cms_menu_items"}])
