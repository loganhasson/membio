class ShowHelpWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(phone_number)
    TextMessage.new(phone_number).show_help.deliver
  end

end