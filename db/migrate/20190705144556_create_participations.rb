class CreateParticipations < ActiveRecord::Migration[5.2]
  def change
    create_table :participations do |t|
      t.boolean    :active, default: true
      t.boolean    :done, default: false
      t.references :user, foreign_key: true
      t.references :round, foreign_key: true

      t.timestamps
    end
  end
end
