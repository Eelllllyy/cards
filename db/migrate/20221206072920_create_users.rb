# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.integer :number
      t.string :code, index: { unique: true }
      t.boolean :passed, default: false
      t.bigint :tg_id, index: { unique: true }

      t.timestamps
    end
  end
end
