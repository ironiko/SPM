class AddFieldsToUsers < ActiveRecord::Migration
	def change
		add_column :users , :nombre_completo, :text
		add_column :users , :nickname, :string
		add_column :users , :colegio, :string
		add_column :users , :curso, :string
	end
end
