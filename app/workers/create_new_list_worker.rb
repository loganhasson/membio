class CreateNewListWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(phone_number, body)
    list_title = body[1..-1].downcase

    list = User.find_by(phone_number: phone_number).lists.build(title: list_title)
    if list.save
      message = "Successfully created list"
      success = true
    else
      message = "Error creating list"
      success = false
    end
    
    TextMessage.new(phone_number).create_new_list(list_title, message, success).deliver
  end

end