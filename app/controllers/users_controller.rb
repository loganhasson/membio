class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params.merge(:confirmed => false))

    if @user.save

      SendConfirmationCodeWorker.perform_async(@user.id)

      respond_to do |format|
        format.js { }
      end

    else
      render :new
    end
  end

  def confirm
    @user = User.find(user_params[:id])
    
    if @user.confirmation_code == user_params[:confirmation_code].to_i
      @user.update(:confirmed => true)
      render text: "Confirmed!"
    else
      render partial: 'confirm'
    end
  end

  private

    def user_params
      params.require(:user).permit(:id, :phone_number, :confirmation_code)
    end

end