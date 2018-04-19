class CreateProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.string :last_name
      t.decimal :latitude
      t.decimal :longitude
      t.references :user, foreign_key: true
      t.string :street_address
      t.string :city
      t.string :postcode
      t.string :state
      t.string :country_code

      t.timestamps
    end
  end
end
