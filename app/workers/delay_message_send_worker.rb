class DelayMessageSendWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(phone_number, text_content)
    TextMessage.new(phone_number).reminder_message(text_content).deliver
  end

end