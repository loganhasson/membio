class NonExistentUserWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(phone_number)
    TextMessage.new(phone_number).non_existent_user.deliver
  end

end