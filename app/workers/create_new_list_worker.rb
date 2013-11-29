class CreateNewListWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(phone_number, body)

  end

end