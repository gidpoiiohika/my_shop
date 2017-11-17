class AddVotesCountToItems < ActiveRecord::Migration[5.0]
  def change
  	add_column :items, :votes_count, :integer, default: 0
  end
end
