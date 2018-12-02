module BaseActions
  extend ActiveSupport::Concern
  include Objects

  included do
    before_action :set_object, only: %I[show update new_report report discard]
    before_action :authenticate_user!
  end

  def index
    self.objects  = model.kept.ordered.search(params[:search]).page(params[:page]).per OBJECTS_PER_PAGE
    self.objects.order_values.prepend "#{params[:sort]} #{params[:dir]}" if params[:sort].present? && model.permitted_params.include?(params[:sort])
    # filter_params = params.permit filter_fields
    # @sorted       = filter_params.present?
    # self.objects  = objects.filter_with(filter_params).includes(model.belongs) # TODO include shown fields of belongs
  end

  def show
  end

  def new_report
  end

  def new
  	self.object = model.new
  end

  def create
    self.object = model.new(model_params)
    respond_to do |format|
      if self.object.save
        flash[:success] = t('views.flash.success.create', model: model.model_name.human)
        format.html { head   :created, location: path }
        format.json { render :show, status: :created, location: self.object }
      else
        format.html { render :new, layout: false }
        format.json { render json: self.object.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if self.object.update(model_params)
        flash[:success] = t('views.flash.success.update', model: model.model_name.human)
        format.html { head   :created, location: path }
        format.json { render :show, status: :ok, location: self.object }
      else
        format.html { render :show, layout: false }
        format.json { render json: self.object.errors, status: :unprocessable_entity }
      end
    end
  end

  def discard
    if self.object.discard
      flash[:success] = t('views.flash.success.discard', model: model.model_name.human)
      head :no_content, location: path
    end
  end

  private

  OBJECTS_PER_PAGE = 20  # todo user settings

  def set_object
    self.object = model.kept.find(params[:id])
  end

  def model_params
    params.require(model.model_name.singular).permit model.permitted_params
  end


end
