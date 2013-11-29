class ParseCommandWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(arguments)
  end
end