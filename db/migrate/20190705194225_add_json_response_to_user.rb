class AddJsonResponseToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :json_response, :json
    add_column :users, :json_completed_katas, :json
  end
end
