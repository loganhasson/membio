class ScheduleReminderWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(phone_number, body)
    raw_body = body[1..-1]
    user = User.find_by(phone_number: phone_number)
    list_exists = false
    item_exists = false
    list_title_or_item, time = raw_body.split('~').first.downcase,
                               raw_body.split('~').last

    if list = List.where(title: list_title_or_item, user: user).first
      list_exists = true
    elsif user
      item_ids = user.lists.map {|list| list.id}.flatten
      if item = Item.where('list_id IN ?', item_ids).where(:content => list_title_or_item).first
        item_exists = true
      end
    else
      DoNotUnderstandWorker.perform_async(phone_number)
    end

    if list_exists
      list_id = list.id
      ListReminderWorker.perform_async(phone_number, list_id, time)
    elsif item_exists
      item_id = item.id
      ItemReminderWorker.perform_async(phone_number, item_id, time)
    end

  end

end