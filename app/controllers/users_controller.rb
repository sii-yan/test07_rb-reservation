 class UsersController < ApplicationController
  before_action :authenticate_user!

  # アカウント設定ページ
  def account
    @user = current_user
  end

  # アカウント情報更新処理
  def update_account
    @user = current_user

    # パスワードの変更を含む場合
    if account_params[:password].present?
      unless account_params[:current_password].present?
        flash.now[:alert] = "現在のパスワードを入力してください。"
        return render :account
      end

      if @user.update_with_password(account_params)
        bypass_sign_in(@user)
        redirect_to account_users_path, notice: "アカウント情報を更新しました。"
      else
        render :account
      end
    else
      # パスワードを変更しない場合
      if @user.update(account_params.except(:current_password))
        redirect_to account_users_path, notice: "アカウント情報を更新しました。"
      else
        render :account
      end
    end
  end

  # プロフィール詳細ページ
  def profile
    @user = current_user
  end

  # プロフィール編集ページ
  def edit_profile
    @user = current_user
  end

  # プロフィール更新処理
  def update_profile
    @user = current_user
    if @user.update(profile_params)
      redirect_to profile_users_path, notice: "プロフィールを更新しました。"
    else
      render :edit_profile
    end
  end

  private

  def profile_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :profile_image, :bio)
  end

  def account_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password)
  end
end
