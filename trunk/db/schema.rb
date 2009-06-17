# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20080609212750) do

  create_table "achievements", :force => true do |t|
    t.string   "location"
    t.datetime "achievement_date"
    t.text     "description"
    t.text     "means",            :limit => 255
    t.string   "privacy"
    t.integer  "portfolio_id",                    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "activities", :force => true do |t|
    t.string   "description"
    t.string   "location"
    t.datetime "start_date"
    t.datetime "end_date"
    t.text     "result"
    t.string   "privacy"
    t.integer  "portfolio_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.text     "body"
    t.integer  "user_id",    :null => false
    t.integer  "post_id",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts_users", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "contact_id"
  end

  create_table "experiences", :force => true do |t|
    t.string   "employer"
    t.string   "role"
    t.string   "location"
    t.datetime "start_date"
    t.datetime "end_date"
    t.text     "notes"
    t.string   "privacy"
    t.integer  "portfolio_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "institutions", :force => true do |t|
    t.string   "name"
    t.string   "location"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "portfolio_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "privacy"
  end

  create_table "links", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.text     "description"
    t.string   "privacy"
    t.integer  "portfolio_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "meetings", :force => true do |t|
    t.string   "attendees"
    t.string   "location"
    t.datetime "meeting_date"
    t.text     "result"
    t.string   "privacy"
    t.integer  "portfolio_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "portfolios", :force => true do |t|
    t.string   "title"
    t.integer  "user_id",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "portfolio_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "privacy"
  end

  create_table "qualifications", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "grade"
    t.datetime "qualification_date"
    t.integer  "portfolio_id",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "institution_id"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "hashed_password"
    t.string   "salt"
    t.string   "first_name"
    t.string   "surname"
    t.string   "email"
    t.text     "address"
    t.string   "phone_number"
    t.string   "status"
    t.string   "image_url"
    t.boolean  "administrator"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
