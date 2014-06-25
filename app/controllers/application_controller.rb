class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception
	
	before_filter :configure_permitted_parameters, if: :devise_controller?


	rescue_from CanCan::AccessDenied do |exception|
		flash[:danger] = exception.message
		redirect_to root_url
	end

	def respond_to_not_found
		flash[:alert] = "contenido no encontrado"

		respond_to do |format|
			format.html { redirect_to(redirection_url) }
			format.json { render :text => flash[:warning],  :status => :not_found }
			format.xml  { render :xml => [flash[:warning]], :status => :not_found }
    	end
	end

	def respond_to_destroy
		flash[:info] = "Usuario Eliminado"
	end

	def redirection_url
	    # Try to redirect somewhere sensible. Note: not all controllers have an index action
	    url = if current_user.present?
	      (respond_to?(:index) and self.action_name != 'index') ? { action: 'index' } : root_url
	    else
	      login_url
	    end
  	end

  	protected
  	def configure_permitted_parameters
  		devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :password_confirmation, :nombre_completo, :colegio, :curso, :role) }
  		devise_parameter_sanitizer.for(:sign_in) << :uid
  		devise_parameter_sanitizer.for(:sign_in) << :provider
    	devise_parameter_sanitizer.for(:account_update) << :nickname
  	end
end
