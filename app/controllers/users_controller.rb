class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params.merge(:confirmed => false))

    if @user.save
      SendConfirmationCodeWorker.perform_async(@user.id)
      render text: "Registered...confirmation code sent!"
    else
      render :new
    end
  end

  def confirm
  end

  private

    def user_params
      params.require(:user).permit(:phone_number)
    end

end