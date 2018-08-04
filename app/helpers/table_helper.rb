module TableHelper

  def th_sortable(app_model, column)
    if app_model.sortable_fields.include? column
      dir = column == params[:sort] && params[:dir] == "asc" ? "desc" : "asc"
      tag_attributes = " data-url='#{transactions_path sort: column, dir: dir}'" +
        " class='sortable" + (column == params[:sort] ? " current #{params[:dir]}'" : "'")
    end
    "<th#{tag_attributes}>#{app_model.human_attribute_name column}</th>"
  end

  def format_amount(object)
	colors = { Kirim: :success, Chiqim: :danger, Ko‘chirish: :secondary }
    tag_attributes = " class='text-#{colors[object.type]}'"
    "<span#{tag_attributes}>#{number_to_currency(object.amount, unit: object.account.currency)}</span>"
  end


end