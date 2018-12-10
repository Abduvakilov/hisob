class Nested::PricesController < NestedController
  def index
    @prices = Price.kept.includes(:product_type, :price_type).
      page(params[:page]).per(rows_per_page).
      joins('join products p on p.category_id = prices.product_type_id or p.id = prices.product_id').
      where('p.id = ?', params[:product_id]).order('created_at desc')
    @prices.order_values.prepend("#{params[:sort]} #{params[:dir]}") if params[:sort].present? && Price.permitted_params.include?(params[:sort])
  end
	def parent_class
    Product
	end
end
