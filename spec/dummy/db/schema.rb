ActiveRecord::Schema.define do

  create_table :pages, force: true do |t|
    t.string :slug
    t.string :image
    t.timestamps null: false
  end

  create_table :page_translations, force: true do |t|
    t.integer  :page_id, null: false
    t.string   :locale,     null: false
    t.string   :title,      null: false
    t.text   :content
    t.timestamps null: false
  end

  create_table :admin_notes, force: true do |t|
    t.string :image
    t.timestamps null: false
  end

  create_table :admin_note_translations, force: true do |t|
    t.integer  :admin_note_id, null: false
    t.string   :locale,     null: false
    t.string   :title,      null: false
    t.timestamps null: false
  end

end
