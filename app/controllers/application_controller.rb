class ApplicationController < ActionController::Base
  include CanCan::ControllerAdditions
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
  before_action :authenticate_user!


end
