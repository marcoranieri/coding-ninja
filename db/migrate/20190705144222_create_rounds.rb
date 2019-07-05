class CreateRounds < ActiveRecord::Migration[5.2]
  def change
    create_table :rounds do |t|
      t.string     :kata_id
      t.time       :duration
      t.text       :notes
      t.boolean    :active, default: true
      t.integer    :winners, array: true, default: []
      t.references :game, foreign_key: true

      t.timestamps
    end
  end
end
