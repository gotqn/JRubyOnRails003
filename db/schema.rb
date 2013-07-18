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

ActiveRecord::Schema.define(:version => 20130718195550) do

  create_table "issues", :force => true do |t|
    t.string    "title"
    t.string    "description"
    t.string    "contacts"
    t.string    "instantiated_by"
    t.boolean   "is_proceed"
    t.timestamp "created_at",      :null => false
    t.timestamp "updated_at",      :null => false
  end

  create_table "security_users", :force => true do |t|
    t.string    "email"
    t.string    "password_digest"
    t.timestamp "registration_date"
    t.timestamp "last_log_in_date"
    t.boolean   "is_active"
    t.string    "activation_code"
    t.timestamp "created_at",             :null => false
    t.timestamp "updated_at",             :null => false
    t.string    "captcha"
    t.string    "auth_token"
    t.string    "password_reset_token"
    t.timestamp "password_reset_sent_at"
  end

  create_table "security_users_details", :force => true do |t|
    t.string    "faculty_number"
    t.string    "egn"
    t.string    "first_name"
    t.string    "last_name"
    t.string    "gender"
    t.string    "address"
    t.string    "city"
    t.string    "country"
    t.string    "gsm"
    t.string    "skype"
    t.timestamp "created_at",       :null => false
    t.timestamp "updated_at",       :null => false
    t.integer   "security_user_id"
  end

  create_table "security_users_manage_securities", :force => true do |t|
    t.integer   "security_user_id"
    t.integer   "security_users_role_id"
    t.timestamp "created_at",             :null => false
    t.timestamp "updated_at",             :null => false
  end

  add_index "security_users_manage_securities", ["security_user_id"], :name => "index_security_users_manage_securities_on_security_user_id"
  add_index "security_users_manage_securities", ["security_users_role_id"], :name => "index_security_users_manage_securities_on_security_users_role_id"

  create_table "security_users_roles", :force => true do |t|
    t.string    "role"
    t.string    "description"
    t.timestamp "created_at",  :null => false
    t.timestamp "updated_at",  :null => false
  end

  create_table "webinars", :force => true do |t|
    t.string    "name"
    t.string    "access_type"
    t.boolean   "is_active"
    t.string    "summary"
    t.timestamp "created_at",         :null => false
    t.timestamp "updated_at",         :null => false
    t.string    "video_file_name"
    t.string    "video_content_type"
    t.integer   "video_file_size"
    t.timestamp "video_updated_at"
  end

end
