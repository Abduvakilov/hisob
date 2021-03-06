class CategoriesController < ApplicationController
  before_action :set_title, only: [:index, :show, :new]
  def index
    self.objects  = model.kept.ordered.
      where(for: params[:for]).
      search(params[:search]).
      page(params[:page]).per rows_per_page
    self.objects.order_values.prepend "#{params[:sort]} #{params[:dir]}" if
      params[:sort].present? && model.permitted_params.include?(params[:sort])
  end

  def show
    @discardable = params[:id] != Category::DEFAULT_PRICE_TYPE_ID.to_s
  end

  def create
    @category = Category.new(model_params)
    respond_to do |format|
      if @category.save
        flash[:success] = t('views.flash.success.create', model: category_name)
        format.html { head :ok, location: categories_path(for: @category.for) }
        format.json { render :show, status: :created, location: self.object }
      else
        format.html { render :new, layout: false }
        format.json { render json: self.object.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @category.update(model_params)
        flash[:success] = t('views.flash.success.update', model: category_name)
        format.html { head :ok, categories_path(for: @category.for) }
        format.json { render :show, status: :ok, location: self.object }
      else
        format.html { render :show, layout: false }
        format.json { render json: self.object.errors, status: :unprocessable_entity }
      end
    end
  end

  def discard
    if @category.discard
      flash[:success] = t('views.flash.success.discard', model: category_name)
      respond_to do |format|
        format.html { head :ok, location: categories_path(for: @category.for) }
        format.json { head :no_content }
      end
    end
  end

  private
  def category_name
    @category.for ? I18n.t('activerecord.models.category.'+@category.for.downcase) : model.model_name.human
  end
  def set_title
    @title = I18n.t("views.title.categories.#{(params[:for] || @category.for).downcase}.#{action_name}") if params[:for] || @category&.for
  end
end
