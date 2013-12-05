class ItemReminderWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(phone_number, item_id, time)
    if parsed_time = Chronic.parse(time)
      item = Item.find(item_id)
      body = <<-SMS
REMINDER
- #{item.content}
SMS
      DelayMessageSendWorker.perform_at(parsed_time, phone_number, body)
    else
      DoNotUnderstandWorker.perform_async(phone_number)
    end

  end

end