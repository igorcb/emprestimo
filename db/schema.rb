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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140111220443) do

  create_table "advances", force: true do |t|
    t.date     "data",                               null: false
    t.decimal  "valor",      precision: 9, scale: 2, null: false
    t.decimal  "saldo",      precision: 9, scale: 2, null: false
    t.integer  "parcelas",                           null: false
    t.integer  "empresa_id",                         null: false
    t.integer  "cliente_id",                         null: false
    t.integer  "uuid",                               null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "advances", ["empresa_id", "cliente_id", "uuid"], name: "index_advances_on_empresa_id_and_cliente_id_and_uuid", unique: true

  create_table "cidades", force: true do |t|
    t.string   "nome",       limit: 50, null: false
    t.integer  "sabado"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cidades", ["nome"], name: "index_cidades_on_nome", unique: true

  create_table "clientes", force: true do |t|
    t.string   "nome",       limit: 50, null: false
    t.string   "cidade",     limit: 20, null: false
    t.integer  "empresa_id",            null: false
    t.integer  "uuid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "clientes", ["empresa_id", "uuid"], name: "index_clientes_on_empresa_id_and_uuid", unique: true

  create_table "empresas", force: true do |t|
    t.string   "nome"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "item_advances", force: true do |t|
    t.string   "parcela",         limit: 10,                          null: false
    t.decimal  "valor",                      precision: 10, scale: 2, null: false
    t.date     "data_vencimento",                                     null: false
    t.string   "status",          limit: 1,                           null: false
    t.integer  "atraso",                                              null: false
    t.date     "data_pagamento"
    t.decimal  "valor_pago"
    t.integer  "advance_id",                                          null: false
    t.integer  "empresa_id",                                          null: false
    t.integer  "uuid",                                                null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "item_advances", ["empresa_id", "uuid"], name: "index_item_advances_on_empresa_id_and_uuid", unique: true

  create_table "users", force: true do |t|
    t.string   "login",           limit: 30
    t.integer  "empresa_id"
    t.integer  "cidade_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
  end

  add_index "users", ["cidade_id"], name: "index_users_on_cidade_id"
  add_index "users", ["empresa_id"], name: "index_users_on_empresa_id"
  add_index "users", ["login"], name: "index_users_on_login", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
