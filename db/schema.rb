# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121130201646) do

  create_table "account_files", :force => true do |t|
    t.string   "title"
    t.integer  "directory_id"
    t.integer  "user_id"
    t.integer  "batch_id"
    t.string   "content"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "account_files", ["batch_id"], :name => "index_account_files_on_batch_id"
  add_index "account_files", ["directory_id"], :name => "index_account_files_on_directory_id"
  add_index "account_files", ["user_id"], :name => "index_account_files_on_user_id"

  create_table "albums", :force => true do |t|
    t.string   "title"
    t.string   "filename"
    t.text     "desc"
    t.boolean  "active"
    t.string   "heading"
    t.string   "nav"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "batches", :force => true do |t|
    t.integer  "submission_id"
    t.integer  "user_id"
    t.integer  "directory_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "batches", ["directory_id"], :name => "index_batches_on_directory_id"
  add_index "batches", ["user_id"], :name => "index_batches_on_user_id"

  create_table "blocks", :force => true do |t|
    t.boolean  "show_title"
    t.string   "title"
    t.text     "body"
    t.string   "where_to_show"
    t.text     "show"
    t.string   "classes"
    t.integer  "weight"
    t.string   "partial_name"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "ckeditor_assets", :force => true do |t|
    t.string   "data_file_name",                                 :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 25
    t.string   "guid",              :limit => 10
    t.integer  "locale",            :limit => 1,  :default => 0
    t.integer  "user_id"
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "fk_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_assetable_type"
  add_index "ckeditor_assets", ["user_id"], :name => "fk_user"

  create_table "cms_menu_items", :force => true do |t|
    t.string   "title"
    t.string   "url"
    t.string   "controller_name"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "parent_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "contacts", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "company_name"
    t.string   "phone"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "message"
    t.string   "hear"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "directories", :force => true do |t|
    t.string   "title"
    t.integer  "user_id"
    t.integer  "parent_directory_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "directories", ["user_id"], :name => "index_directories_on_user_id"

  create_table "keys", :force => true do |t|
    t.string   "word"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "menu_items", :force => true do |t|
    t.string   "title"
    t.string   "url"
    t.boolean  "active"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "parent_id"
    t.integer  "linkable_id"
    t.string   "linkable_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "newsletters", :force => true do |t|
    t.string   "title"
    t.string   "document"
    t.text     "summary"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "pages", :force => true do |t|
    t.boolean  "active"
    t.string   "partial_name"
    t.text     "description"
    t.string   "keywords"
    t.string   "title"
    t.string   "filename"
    t.string   "nav_link"
    t.string   "heading"
    t.string   "classes"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "photos", :force => true do |t|
    t.string   "title"
    t.text     "desc"
    t.date     "date_shot"
    t.string   "location"
    t.integer  "album_id"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.boolean  "published"
    t.datetime "published_at"
    t.boolean  "share"
    t.string   "slug"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "image"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string "name"
  end

  create_table "slides", :force => true do |t|
    t.text     "caption"
    t.string   "url"
    t.boolean  "active"
    t.integer  "position"
    t.integer  "width"
    t.integer  "height"
    t.string   "image"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "testimonials", :force => true do |t|
    t.text     "quote"
    t.string   "attribution"
    t.boolean  "approved"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "username",                        :null => false
    t.string   "email"
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.datetime "last_login_at"
    t.datetime "last_logout_at"
    t.datetime "last_activity_at"
    t.string   "activation_state"
    t.string   "activation_token"
    t.datetime "activation_token_expires_at"
    t.integer  "role_id"
  end

  add_index "users", ["activation_token"], :name => "index_users_on_activation_token"
  add_index "users", ["last_logout_at", "last_activity_at"], :name => "index_users_on_last_logout_at_and_last_activity_at"
  add_index "users", ["remember_me_token"], :name => "index_users_on_remember_me_token"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token"

end
