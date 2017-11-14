class Companies::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  after_action :reset_company_services, only: [:update]
  after_action :create_company_services_at_sign_up, only: [:create]

  # GET /resource/sign_up
  def new
    @selected_service_categories = []
    @service_categories = ServiceCategory.all
    super
  end

  # POST /resource
  def create
    @selected_service_categories = params["service_category"]
    @service_categories = ServiceCategory.all
    super
  end

  # GET /resource/edit
  def edit
    @service_categories = ServiceCategory.all
    super
  end

  # PUT /resource
  def update
    @service_categories = ServiceCategory.all
    super
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :zip_code, :phone,
      :description, :url, :address, :city, :state, :service_radius, :service_category, :avatar])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :zip_code, :phone,
      :description, :url, :address, :city, :state, :service_radius, :service_category, :avatar])
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  def create_company_services_at_sign_up
    reset_company_services
  end

  def reset_company_services
    resource.company_services.destroy_all if resource.company_services
    if params[:service_category]
      params[:service_category].each do |service_category|
        CompanyService.create(
          company_id: resource.id,
          service_category_id: service_category.to_i
        )
      end
    end
  end
end
