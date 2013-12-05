class ListReminderWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(phone_number, list_id, time)
    if parsed_time = Chronic.parse(time)
      list = List.find(list_id)
      title = list.title
      list_items = ""
      list.items.each do |item|
        list_items << "- #{item.content}\n"
      end
      body = <<-SMS
REMINDER
#{title}:
#{list_items}
SMS
      DelayMessageSendWorker.perform_at(parsed_time, phone_number, body)
    else
      DoNotUnderstandWorker.perform_async(phone_number)
    end
  end

end