class FeedBroadcastWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(phone_number, body)
    combined_data = {phone_number: phone_number, body: body}.to_json
    message = {:channel => '/getting-started/feed', :data => combined_data}
    uri = URI.parse("http://localhost:9292/getting-started/faye")
    Net::HTTP.post_form(uri, :message => message.to_json)
  end

end