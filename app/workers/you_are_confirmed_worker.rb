class YouAreConfirmedWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(phone_number)
    TextMessage.new(phone_number).you_are_confirmed.deliver
  end

end