class UsersController < ApplicationController
  def settings
    if request.patch?
      if current_user.update(model_params)
        head :ok, location: root_path
      else
        render :settings, layout: false
      end
    end
  end
end
