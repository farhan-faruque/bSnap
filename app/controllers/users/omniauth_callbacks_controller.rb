class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_action :find_authentication

   def method_missing(provider)
     return super unless valid_provider?(provider)
     omniauth_authorize_additional_account || omniauth_sign_in || omniauth_sign_up
   end

  def omniauth_authorize_additional_account
    return false unless user_signed_in?

    if @authentication && @authentication.user != current_user
      flash[:alert] = "You have created two accounts and they can't be merged automatically"
    else
      current_user.apply_omniauth @omniauth
      flash[:notice] = "Account connected" if current_user.save
    end

    sign_in_and_redirect :user, current_user
  end

  def omniauth_sign_in
    return false unless @authentication
    flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => @omniauth['provider']
    sign_in_and_redirect @authentication.user, event: :authentication
    true
  end

  def omniauth_sign_up
    email = @omniauth.deep_find("email")
    user = User.where(email: email).first unless email.blank?
    if user && user.valid?
      user.apply_omniauth @omniauth
      user.save
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => @omniauth['provider']
      sign_in_and_redirect(:user, user)
    else
      session["devise.original.image"] = image_url
      session["devise.omniauth"] = @omniauth.except("extra")
      redirect_to new_user_registration_path
    end
  end


  protected

  def find_authentication
    @omniauth = env["omniauth.auth"]
    @authentication = Authentication.find_by_oauth(@omniauth) if @omniauth
  end

  def image_url
    @omniauth[:extra][:raw_info][:pictureUrls][:values].first
  end

end
