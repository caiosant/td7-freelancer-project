class AddOccupationAreaToProfile < ActiveRecord::Migration[6.1]
  def change
    add_reference :profiles, :occupation_area, null: true, foreign_key: true
  end
end
