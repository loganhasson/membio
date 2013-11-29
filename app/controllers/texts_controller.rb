class TextsController < ApplicationController

  def parse
    User.create(:phone_number => params[:From])
    # phone number = params[:From]
    # body         = params[:Body]
    head :ok, :content_type => 'text/html'
  end

end