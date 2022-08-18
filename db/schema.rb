# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_07_27_082127) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "agent_roles", id: false, force: :cascade do |t|
    t.bigint "agent_id"
    t.bigint "role_id"
    t.index ["agent_id"], name: "index_agent_roles_on_agent_id"
    t.index ["role_id"], name: "index_agent_roles_on_role_id"
  end

  create_table "agents", force: :cascade do |t|
    t.string "privy_id"
    t.string "access_token"
    t.string "name"
    t.boolean "enable", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["access_token"], name: "index_agents_on_access_token"
    t.index ["privy_id"], name: "index_agents_on_privy_id"
  end

  create_table "configurations", force: :cascade do |t|
    t.string "key"
    t.string "value"
  end

  create_table "roles", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
