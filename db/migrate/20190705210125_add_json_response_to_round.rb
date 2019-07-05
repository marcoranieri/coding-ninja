class AddJsonResponseToRound < ActiveRecord::Migration[5.2]
  def change
    add_column :rounds, :json_response, :json
  end
end
