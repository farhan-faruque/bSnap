class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters

  def new
    @looking_for = ["Personal" , "Business"]
    super
  end

  def create
    @looking_for = ["Personal" , "Business"]
    super
    if current_user
      profile = current_user.build_profile profile_params
      profile.save
      UserMailer.welcome_mail(current_user).deliver
    end

  end


  def build_resource(*args)
    super
    if session['devise.omniauth']
      @user.apply_omniauth(session['devise.omniauth'])
      #@user.build_user_profile(session['devise.omniauth'],session["devise.original.image"])
      @user.valid?
    end
  end


  private

  # def sign_up_params
  #   #params.require(:user).permit(:user_name, :email, :password, :password_confirmation)
  #   devise_parameter_sanitizer.for(:user) { |u| u.permit(:user_name, :email, :password, :password_confirmation) }
  # end
  #
  # def account_update_params
  #   #params.require(:user).permit(:user_name, :email, :password, :password_confirmation, :current_password)
  #   devise_parameter_sanitizer.for(:user) { |u| u.permit(:user_name, :email, :password, :password_confirmation,:current_password) }
  # end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:user_name, :email, :password, :password_confirmation) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:user_name, :email, :password, :password_confirmation, :current_password) }
  end

  def profile_params
    params.require(:profile).permit(:location_id, :lookingfor)
  end

end
