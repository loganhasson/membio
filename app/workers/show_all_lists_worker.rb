class ShowAllListsWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(phone_number)
    TextMessage.new(phone_number).show_all_lists(phone_number).deliver
  end

end