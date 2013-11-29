class CompleteListWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(phone_number, body)
    list_title = body[1..-1].downcase

    if list = List.where(title: list_title, user: User.find_by(phone_number: phone_number)).first
      if list.destroy
        TextMessage.new(phone_number).complete_list(list_title, true).deliver
      else
        TextMessage.new(phone_number).complete_list(list_title, false).deliver
      end
    else
      TextMessage.new(phone_number).complete_list(list_title, false).deliver
    end
    
  end

end