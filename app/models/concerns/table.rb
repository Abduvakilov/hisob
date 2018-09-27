module Table

	module Fields

	  def permitted_params
	    column_names - ['id', 'created_at', 'updated_at', 'discarded_at']
	  end

	  def shown_fields
	  	sortable_fields + belongs
	  end

	  def belongs(suffix=nil)
	    reflect_on_all_associations(:belongs_to).map { |x| x.name.to_s + suffix.to_s }
	  end
	end


	module Search

	  def search(query)
	    if searched_fields && !query.blank?
	      where multiple_like_query(searched_fields), q: "%#{query}%"
	    else
	      all
	    end
	  end

	  def searched_by_child
	    nil      # This should be implemented to search among belongs_to
	  end

	  private

	  def searched_fields
	    permitted_params + belong_search_fields - belongs('_id')
	  end

	  def belong_search_fields
	  	belong_classes = reflect_on_all_associations(:belongs_to).map &:klass
	    belong_classes.reduce([]) { |memo, x|
	      case x.searched_by_child
	      when Array
	        x.searched_by_child.each do |field|
	          memo.push "#{x}.#{field}"
	        end
				when String, Symbol
          memo.push "#{x}.#{x.searched_by_child}"
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

	  def sortable_fields
	    permitted_params - belongs('_id')
	  end

	end


end
