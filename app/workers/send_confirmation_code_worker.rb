class SendConfirmationCodeWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(user_id)
    user = User.find(user_id)
    phone_number = user.phone_number
    confirmation_code = user.confirmation_code
    TextMessage.new(phone_number).confirmation_code(confirmation_code).deliver
  end

end