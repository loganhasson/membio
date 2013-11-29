class TextMessage

  def initialize(to)
    client = Twilio::REST::Client.new(TWILIO_SID, TWILIO_AUTH_TOKEN)
    @to = to
    @from = COMPANY_SMS_NUMBER
    @account = client.account
  end

  def invitation(name,url)
    @body = "Ho, ho, ho! Send me your wishlist, #{name}: #{url}\n-Santa"
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