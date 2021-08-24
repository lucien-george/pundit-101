class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  include Pundit

  # whitelist approach
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  # Uncomment when you're comfortable with pundit
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end

  # def user_not_authorized
  #   redirect_to root_path, alert: "You are not authorized to perform this action"
  # end
end
