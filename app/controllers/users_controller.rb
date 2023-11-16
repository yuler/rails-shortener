class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user = User.find_by(email: @user.email)
    if @user
      @user.send_magic_link_mail!
      redirect_to root_path, notice: "Email send success"
      return
    end

    @user = User.new(user_params)
    if @user.save
      @user.send_magic_link_mail!
      flash[:success] = "Email send success"
      redirect_to root_path
    else
      flash[:error] = "Something went wrong"
      render :new, status: :unprocessable_entity
    end
  end

  @private

  def user_params
    params.require(:user).permit(:email)
  end
end
