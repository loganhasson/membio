class TextMessage

  # USAGE: TextMessage.new(phone_number).confirmation_code(confirmation_code).deliver
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

  def deliver
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