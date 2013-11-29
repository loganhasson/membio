class TextsController < ApplicationController

  def parse
    phone_number = params[:From].gsub(/^(\+1)|[^0-9]+/,'')
    body = params[:Body]

    ParseMessageWorker.perform_async(phone_number, body)
    
    head :ok, :content_type => 'text/html'
  end

end