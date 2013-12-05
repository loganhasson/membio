class TextMessage

  def initialize(to)
    client = Twilio::REST::Client.new(TWILIO_SID, TWILIO_AUTH_TOKEN)
    @to = to
    @from = COMPANY_SMS_NUMBER
    @account = client.account
  end

  def confirmation_code(confirmation_code)
    @body = "Thanks for signing up for membio! Here's your confirmation code: #{confirmation_code}"
    self
  end

  def create_new_list(list_title, message, success)
    if success == true
      @body = "#{message}: #{list_title}"
    else
      @body = "#{message}: #{list_title}. Please try again."
    end
    self
  end

  def display_list(list_title, list_id, found)
    if found
      list = List.find(list_id)

      list_items = ""
      list.items.each do |item|
        list_items << "- #{item.content}\n"
      end

      if list.items.size < 1
        @body = "#{list.title} is empty. Go ahead and add to it!"
      else
        @body = <<-SMS
#{list.title}:
#{list_items}
SMS
      end
    else
      @body = "#{list_title} doesn't exist."
    end
    self
  end

  def complete_list(list_title, destroyed)
    if destroyed
      @body = "Successfully marked #{list_title} as complete."
    else
      @body = "There was an error marking #{list_title} as complete. Are you sure it exists?"
    end
    self
  end

  def show_all_lists(phone_number)
    user = User.find_by(:phone_number => phone_number)
    if user && user.lists.size > 0
      @body = "Your Lists:\n"
      user.lists.each do |list|
        @body << "- #{list.title}\n"
      end
    else
      @body = "You don't seem to have any lists. Go ahead and make one!"
    end
    self
  end

  def update_list(list_title, list_id, found)
    if found
      list = List.find(list_id)

      list_items = ""
      list.items.each do |item|
        list_items << "- #{item.content}\n"
      end

      @body = <<-SMS
Updated list: #{list.title}
#{list_items}
SMS
    else
      @body = "#{list_title} doesn't exist."
    end
    self
  end

  def do_not_understand
    @body = "Sorry, I don't understand. If you need help, reply with '?'"
    self
  end

  def show_help
    @body = <<-HELP
How membio works:
- New: @Listname
- Add: Listname+item1, item2...
- Remove: Listname-item
- View: #Listname
- Complete: !Listname
- All: *
- Help: ?
HELP
    self
  end

  def non_existent_user
    @body = "It looks like you don't have a membio account yet! Go sign up at: #{URL}"
    self
  end

  def non_confirmed_user(confirmation_code)
    @body = "It seems like you haven't confirmed your account yet! Your confirmation code is: #{confirmation_code}. Enter it at: confirmation_link_here"
    self
  end

  def you_are_confirmed
    @body = "Your account is confirmed and all ready to go! If you need help getting started, reply with '?'"
    self
  end

  def reminder_message(reminder_body)
    @body = reminder_body
    self
  end

  def deliver
    # TODO deal with messages over 150 chars
    @account.sms.messages.create({from: @from, to: @to, body: @body})
  end

  def deliver!
    puts "Sending Text Message..."
    puts "To: #{@to}"
    puts "From: #{@from}"
    puts "Message: #{@body}"
    puts "Sent!"
  end

end