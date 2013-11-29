class RemoveFromListWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(phone_number, body)
    list_title, items = body.split('-').first.downcase,
                        body.split('-').last
                            .split(', ')
                            .map { |i| i.strip.split(',') }
                            .flatten

    if list = List.where(title: list_title, user: User.find_by(phone_number: phone_number)).first
      items.each do |item|
        if temp_item = list.items.find_by(:content => item)
          temp_item.destroy
        end
      end

      TextMessage.new(phone_number).update_list(list_title, list.id, true).deliver
    else
      TextMessage.new(phone_number).update_list(list_title, nil, false).deliver
    end
  end

end