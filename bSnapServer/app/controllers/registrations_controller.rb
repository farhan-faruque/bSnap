class RegistrationsController < Devise::RegistrationsController

  def new
    @looking_for = ["Personal" , "Business"]

    super
  end

  def create
    super
    if current_user

    end

  end

  private

  def sign_up_params
    params.require(:user).permit(:user_name, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:user_name, :email, :password, :password_confirmation, :current_password)
  end

end
