class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|

      t.text :certificate
      t.string :passphrase
      t.string :gateway
      t.string :device_token
      t.string :alert
      t.string :bytes_sent

      t.timestamps null: false
    end
  end
end
