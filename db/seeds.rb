Dust::Role.create([{:name => "admin"}, {:name => "moderator"}])

Dust::User.create(:username => 'admin', :password => "secret", :password_confirmation => "secret", :email => 'admin@dust.com', :role => Dust::Role.find_by_name("admin"))

Dust::Page.create([{:nav_link => 'Welcome', :meta_title => "Welcome", :active => 1, :filename => "welcome"}, {:nav_link => 'Contact Us', :meta_title => "Contact Us", :active => 1, :filename => "contact-us"}])

Dust::CmsMenuItem.create([{:title =>"Home", :controller_name => "front_end/pages", :url => "/"}, 
	{:title =>"Pages", :controller_name => "admin/pages", :url => "/dust/pages"}, 
	{:title =>"Blocks", :controller_name => "admin/blocks", :url => "/dust/blocks"},
	{:title =>"Contacts", :controller_name => "admin/contacts", :url => "/dust/contacts"}, 
	{:title =>"Roles", :controller_name => "admin/roles", :url => "/dust/roles"}, 
	{:title =>"Users", :controller_name => "admin/users", :url => "/dust/users"}, 
	{:title =>"Menu Items", :controller_name => "admin/menu_items", :url => "/dust/menu_items"}, 
	{:title =>"Manage Menu", :controller_name => "admin/pages", :url => "/dust/menu-manage"}, 	
	{:title =>"Dust Menu Items", :controller_name => "admin/cms_menu_items", :url => "/dust/cms_menu_items"}])
