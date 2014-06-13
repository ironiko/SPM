class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

	rescue_from CanCan::AccessDenied do |exception|
		flash[:error] = exception.message
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
		flash[:notice] = "Usuario Eliminado"
	end

	def redirection_url
	    # Try to redirect somewhere sensible. Note: not all controllers have an index action
	    url = if current_user.present?
	      (respond_to?(:index) and self.action_name != 'index') ? { action: 'index' } : root_url
	    else
	      login_url
	    end
  	end
end
