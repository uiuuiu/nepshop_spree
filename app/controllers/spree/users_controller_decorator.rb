Spree::UsersController.class_eval do
  def show
    @taxonomies = Spree::Taxonomy.all
    @orders = @user.orders.complete.order('completed_at desc')
  end

  def update
    if @user.update_attributes(user_params)
      user_order = Spree::Order.find_by(user_id: @user.id)
      if user_order.present?
        user_order.update(bill_address_id: @user.bill_address_id, ship_address_id: @user.ship_address_id)
      end
      if params[:user][:password].present?
        user = Spree::User.reset_password_by_token(params[:user])
        sign_in(@user, event: :authentication, bypass: !Spree::Auth::Config[:signout_after_password_change])
      end
      redirect_to spree.account_url, notice: Spree.t(:account_updated)
    else
      redirect_to :back
    end
  end

  def user_params
    params.require(:user).permit(:email, :sex, :password, :password_confirmation,
      [ship_address_attributes: permitted_address_attributes,
      bill_address_attributes: permitted_address_attributes])
  end
end
