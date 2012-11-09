Role.create([{:name => "admin"}, {:name => "moderator"}])

User.create(:username => "admin", :password => "secret", :email => "admin@dust.com", :role => Role.find_by_name("admin"))

Page.create([{:nav_link => 'Welcome', :heading => "Welcome To Dust", :title => "Welcome To Dust", :active => 1, :filename => "welcome"},
	{:nav_link => 'Contact', :partial_name => "contact", :heading => "Contact Dust", :title => "Contact Dust", :active => 1, :filename => "contact-us"}])

CmsMenuItem.create([{:title =>"Home", :controller_name => "view_pages", :url => "/"}, 
	{:title =>"Pages", :controller_name => "pages", :url => "/pages"}, 
	{:title =>"Blocks", :controller_name => "blocks", :url => "/blocks"},
	{:title =>"Contacts", :controller_name => "contacts", :url => "/contacts"}, 
	{:title =>"Keywords", :controller_name => "keys", :url => "/keys"},
	{:title =>"Roles", :controller_name => "roles", :url => "/roles"}, 
	{:title =>"Users", :controller_name => "users", :url => "/users"}, 
	{:title =>"Menu Items", :controller_name => "menu_items", :url => "/menu_items"}, 
	{:title =>"Manage Menu", :controller_name => "pages", :url => "/menu-manage"}, 	
	{:title =>"Dust Menu Items", :controller_name => "cms_menu_items", :url => "/cms_menu_items"}])
