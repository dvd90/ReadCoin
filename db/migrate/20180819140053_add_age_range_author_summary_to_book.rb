class AddAgeRangeAuthorSummaryToBook < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :min_age, :integer
    add_column :books, :max_age, :integer
    add_column :books, :author, :string
    add_column :books, :summary, :text
  end
end
