class ShowAllListsWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(phone_number)

  end

end