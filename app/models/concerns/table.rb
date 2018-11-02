module Table

	module Fields

		def base_params
			column_names - ['id', 'created_at', 'updated_at', 'discarded_at']
		end

	  def permitted_params
	    base_params
	  end

	  def shown_fields
	  	sortable_fields + belongs
	  end

	  def form_fields
	  	sortable_fields + belongs
	  end

	  def belongs(suffix=nil)
	    reflect_on_all_associations(:belongs_to).map { |x| x.name.to_s + suffix.to_s }
	  end

	  def belongs_class(field_name)
	    reflect_on_all_associations(:belongs_to).find{ |a| a.name == field_name.to_sym }.klass
	  end

	  def searched_by_child
	    nil      # This should be implemented to search among belongs_to
	  end

	end


	module Search

	  def search(query)
      where(([multiple_like_query(searched_fields), q: "%#{query}%"] if !query.blank? && searched_fields))
	  end

	  private

	  def searched_fields
	    base_params + belong_search_fields - belongs('_id')
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
	    base_params - belongs('_id')
	  end

	end


end
