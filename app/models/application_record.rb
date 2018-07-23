class ApplicationRecord < ActiveRecord::Base

  self.abstract_class = true

  def self.permitted_params
    self.column_names - ['id', 'created_at', 'updated_at']
  end
  
  def self.shown_fields
  	self.sortable_fields + self.belongs
  end

  def self.search(query)
    if fields = self.searched_fields && query
      where multiple_like_query(fields), q: "%#{query}%"
    else
      all
    end

  end

  def to_str
    to_s
  end

  private

  def self.searched_by_childs
    nil      # This should be implemented to search among belongs_to
  end

  def self.sortable_fields
    self.permitted_params - self.belongs('_id')
  end

  def self.searched_fields
    permitted_params + self.belong_search_fields - self.belongs('_id')
  end

  def self.belongs(suffix=nil)
    self.reflect_on_all_associations(:belongs_to).map { |x| x.name.to_s + suffix.to_s }
  end

  def self.belong_search_fields 
    self.belongs.reduce([]) { |memo, x| 
      if fields = x.classify.constantize.searched_by_childs and fields.is_a? Array
        fields.each do |field|
          memo.push "#{x}.#{field}"
        end
      elsif fields.is_a? String
          memo.push "#{x}.#{fields}"
      end
      memo
    }
  end

  def self.multiple_like_query(array)
    array.reduce('') { |memo, x|
      unless memo == ''
        memo += ' or '
      end
      memo += "#{x} like :q"
    }
  end

end
