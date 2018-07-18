class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  def self.shown_columns
  	shown_columns = self.column_names - ['id', 'created_at', 'updated_at']
  	belongs = self.reflect_on_all_associations(:belongs_to).map { |x| x.name.to_s }
  	shown_columns += belongs - belongs.map {|x| x+'_id'}
  end
end
