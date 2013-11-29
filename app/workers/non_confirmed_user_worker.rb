class NonConfirmedUserWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(phone_number)
    confirmation_code = User.find_by(:phone_number => phone_number).confirmation_code
    TextMessage.new(phone_number).non_confirmed_user(confirmation_code).deliver
  end

end