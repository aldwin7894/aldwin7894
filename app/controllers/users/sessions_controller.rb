# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  layout "devise"
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    respond_to do |format|
      self.resource = warden.authenticate(auth_options)

      if resource && resource.active_for_authentication?
        sign_in(resource_name, resource)
      else
        @error = "Invalid username or password"
      end

      format.js
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  def after_sign_in_path_for(customer)
    admin_dashboard_index_path
  end

  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(_resource)
    root_path
  end
end
