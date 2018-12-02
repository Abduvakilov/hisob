module Table

	module Fields

	  def permitted_params
	    base_params
	  end

	  def shown_fields
	  	base_params_without_id
	  end

	  def form_fields
	  	base_params_without_id
	  end

	  def belongs
	    @belongs ||= reflect_on_all_associations(:belongs_to).map { |x| x.name.to_s }
	  end

	  def belongs_with_id
			@belongs_with_id ||= reflect_on_all_associations(:belongs_to).map { |x| x.name.to_s + '_id' }
	  end

	  def belongs_class(field_name)
	    reflect_on_all_associations(:belongs_to).find{ |a| a.name == field_name.to_sym }.klass
	  end

	  def searched_by_child
	    nil      # This should be implemented to search among belongs_to
	  end

	  private
		def base_params
			@base_params ||= column_names - ['id', 'created_at', 'updated_at', 'discarded_at']
		end
		def base_params_without_id
	  	@base_params_without_id ||= base_params.map { |x| x.in?(belongs_with_id) ? x.delete_suffix('_id') : x }
		end

	end


	module Search

	  def search(query)
      where(([multiple_like_query(searched_fields), q: "%#{query}%"] if query.present? && searched_fields))
	  end

	  private

	  def searched_fields
	    @searched_fields ||= base_params + belong_search_fields - belongs_with_id
	  end

	  def belong_search_fields
	  	@belong_search_fields ||= begin
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
	    @sortable_fields ||= base_params - belongs_with_id
	  end

	end


end
