class ParseMessageWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(phone_number, body)
    # TODO check for user registration and confirmation first
    case body[0]
    when "@"
      CreateNewListWorker.perform_async(phone_number, body)
    when "#"
      DisplayListWorker.perform_async(phone_number, body)
    when "!"
      CompleteListWorker.perform_async(phone_number, body)
    when "?"
      ShowAllListsWorker.perform_async(phone_number)
    else
      if body.split('+').size > 1
        AddToListWorker.perform_async(phone_number, body)
      elsif body.split('-').size > 1
        RemoveFromListWorker.perform_async(phone_number, body)
      else
        DoNotUnderstandWorker.perform_async(phone_number)
      end
    end

  end

end