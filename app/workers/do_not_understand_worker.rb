class DoNotUnderstandWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(phone_number)
    TextMessage.new(phone_number).do_not_understand.deliver
  end

end