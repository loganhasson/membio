class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params.merge(:confirmed => false))
    if @user.save
      cookies.delete :error
      SendConfirmationCodeWorker.perform_async(@user.id)
      respond_to do |format|
        format.js { }
      end

    else
      cookies[:error] = @user.errors.full_messages.first
      render :new
    end
  end

  def confirm
    @user = User.find(user_params[:id])
    
    if @user.confirmation_code == user_params[:confirmation_code].to_i
      @user.update(:confirmed => true)
      cookies.delete :error
      # YouAreConfirmedWorker.perform_async(@user.phone_number)
      respond_to do |format|
        format.js { }
      end
      
    else
      cookies[:error] = "Your confirmation code doesn't match"
      render partial: 'confirm'
    end
  end

  # TODO write route to allow people to confirm later
  # def confirm_later
  # end
  
  private

    def user_params
      params.require(:user).permit(:id, :phone_number, :confirmation_code)
    end

end