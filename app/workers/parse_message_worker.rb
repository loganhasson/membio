class ParseMessageWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(phone_number, body)
    if !User.find_by(:phone_number => phone_number)
      NonExistentUserWorker.perform_async(phone_number)
    elsif !User.find_by(:phone_number => phone_number).confirmed?
      NonConfirmedUserWorker.perform_async(phone_number)
    else
      FeedBroadcastWorker.perform_async(phone_number, body)

      case body[0]
      when "@"
        CreateNewListWorker.perform_async(phone_number, body)
      when "#"
        DisplayListWorker.perform_async(phone_number, body)
      when "!"
        CompleteListWorker.perform_async(phone_number, body)
      when "&"
        ScheduleReminderWorker.perform_async(phone_number, body)
      when "*"
        ShowAllListsWorker.perform_async(phone_number)
      when "?"
        ShowHelpWorker.perform_async(phone_number)
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

end