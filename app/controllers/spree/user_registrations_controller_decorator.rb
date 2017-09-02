Spree::UserRegistrationsController.class_eval do
  def spree_user_params
    params.require(:spree_user).permit(:email, :sex, :password, :password_confirmation)
  end
end
