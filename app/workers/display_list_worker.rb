class DisplayListWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(phone_number, body)
    list_title = body[1..-1]

    if list = List.where(title: list_title, user: User.find_by(phone_number: phone_number)).first
      TextMessage.new(phone_number).display_list(list_title, list.id, true).deliver
    else
      TextMessage.new(phone_number).display_list(list_title, nil, false).deliver
    end

  end

end