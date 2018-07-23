module Table

	module Fields

	  def permitted_params
	    column_names - ['id', 'created_at', 'updated_at']
	  end
	  
	  def shown_fields
	  	sortable_fields + belongs
	  end

	  private

	  def belongs(suffix=nil)
	    reflect_on_all_associations(:belongs_to).map { |x| x.name.to_s + suffix.to_s }
	  end
	end


	module Search

	  def search(query)
	    if fields = searched_fields && query
	      where multiple_like_query(fields), q: "%#{query}%"
	    else
	      all
	    end
	  end

	  private

	  def searched_by_childs
	    nil      # This should be implemented to search among belongs_to
	  end

	  def searched_fields
	    permitted_params + belong_search_fields - belongs('_id')
	  end

	  def belong_search_fields 
	    belongs.reduce([]) { |memo, x| 
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

	  def multiple_like_query(array)
	    array.reduce('') { |memo, x|
	      unless memo == ''
	        memo += ' or '
	      end
	      memo += "#{x} like :q"
	    }
	  end
	end


	module Sort

	  private

	  def sortable_fields
	    permitted_params - belongs('_id')
	  end

	end

	
end